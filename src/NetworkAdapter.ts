import { IFetchResponse, INetworkAdapter } from './INetworkAdapter'

export class NetworkAdapter implements INetworkAdapter {
	fetch(url: string, options: { method?: string | undefined; headers?: Headers | undefined; body?: string | Blob | Uint8Array | undefined; }): Promise<IFetchResponse> {
		const { method, headers, body } = options
		return fetch(url, {
			method,
			headers,
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
