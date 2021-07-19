import * as fetchPonyfill from 'fetch-ponyfill'
import { IFetchResponse, INetworkAdapter } from './INetworkAdapter'
const { fetch, Headers } = fetchPonyfill()

export class NetworkAdapter implements INetworkAdapter {
	fetch(url: string, options: { method?: string | undefined; headers?: Record<string, string> | undefined; body?: string | Blob | Uint8Array | undefined; }): Promise<IFetchResponse> {
		const { method, headers, body } = options

		const fetchHeaders = new Headers()
		if (headers) {
			Object.keys(headers).forEach((header) => {
				fetchHeaders.set(header, headers[header])
			})
		}

		return fetch(url, {
			method,
			headers: fetchHeaders,
			body
		})
		.then((response) => Promise.all([response.status, response.text()]))
		.then((statusAndResponse) => ({
			code: statusAndResponse[0],
			body: statusAndResponse[1]
		}))
	}
	wsOpen(url: string): Promise<number> {
		throw new Error('Method not implemented.')
	}
	wsSend(handle: number, data: string): Promise<void> {
		throw new Error('Method not implemented.')
	}
	wsGetMessageFromBuffer(handle: number): Promise<string | undefined> {
		throw new Error('Method not implemented.')
	}
	wsClose(handle: number) {
		throw new Error('Method not implemented.')
	}
}
