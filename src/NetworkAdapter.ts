/**
	Copyright 2021 Jan Starzak

	This file is part of qb.js

	qb.js is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	qb.js is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with qb.js.  If not, see <http://www.gnu.org/licenses/>.
*/

import * as fetchPonyfill from 'fetch-ponyfill'
import { IFetchResponse, INetworkAdapter } from './INetworkAdapter'
const { fetch, Headers } = fetchPonyfill()
import 'websocket-polyfill'

interface SocketHandle {
	socket: WebSocket
	buffer: string[]
}

export class NetworkAdapter implements INetworkAdapter {
	private sockets: (SocketHandle | undefined)[] = []
	private fetchAborts: Set<AbortController> = new Set()

	fetch(
		url: string,
		options: {
			method?: string | undefined
			headers?: Record<string, string> | undefined
			body?: string | Blob | Uint8Array | undefined
		}
	): Promise<IFetchResponse> {
		const { method, headers, body } = options

		const fetchHeaders = new Headers()
		if (headers) {
			Object.keys(headers).forEach(header => {
				fetchHeaders.set(header, headers[header])
			})
		}

		const abortController = new AbortController()
		this.fetchAborts.add(abortController)

		return fetch(url, {
			method,
			headers: fetchHeaders,
			body,
			signal: abortController.signal
		})
			.then(response => {
				this.fetchAborts.delete(abortController)
				return Promise.all([response.status, response.text()])
			})
			.then(statusAndResponse => ({
				code: statusAndResponse[0],
				body: statusAndResponse[1]
			}))
	}
	wsOpen(url: string): Promise<number> {
		return new Promise(resolve => {
			const socket = new WebSocket(url)
			const socketHandle = {
				socket,
				buffer: []
			}
			let idx = this.sockets.findIndex(i => i === undefined)
			if (idx >= 0) {
				this.sockets[idx] = socketHandle
			} else {
				idx = this.sockets.push(socketHandle) - 1
			}
			socket.addEventListener('message', e => this.wsOnMessage(idx, e.data))
			resolve(idx)
		})
	}
	wsSend(handle: number, data: string): Promise<void> {
		return new Promise(resolve => {
			const socketHandle = this.sockets[handle]
			if (!socketHandle) {
				throw new Error('Floating WebSocket handle')
			}
			socketHandle.socket.send(data)
			resolve()
		})
	}
	wsGetMessageFromBuffer(handle: number): Promise<string | undefined> {
		return new Promise(resolve => {
			const socketHandle = this.sockets[handle]
			if (!socketHandle) {
				throw new Error('Floating WebSocket handle')
			}
			resolve(socketHandle.buffer.shift())
		})
	}
	wsClose(handle: number) {
		const socketHandle = this.sockets[handle]
		if (!socketHandle) {
			throw new Error('Floating WebSocket handle')
		}
		socketHandle.socket.close(1000)
		this.sockets[handle] = undefined
	}
	private wsOnMessage(handle: number, message: string) {
		const socketHandle = this.sockets[handle]
		if (!socketHandle) {
			throw new Error('Floating WebSocket handle')
		}
		socketHandle.buffer.push(message)
	}
	reset() {
		this.sockets.forEach(socketHandle => {
			if (socketHandle) {
				socketHandle.socket.close(1001, 'Network adapter reset.')
			}
		})
		this.sockets.length = 0

		this.fetchAborts.forEach(abortController => abortController.abort())
		this.fetchAborts.clear()
	}
}
