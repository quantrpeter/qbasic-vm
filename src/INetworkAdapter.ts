export interface IFetchResponse {
	code: number
	body: string
}

export interface INetworkAdapter {
	fetch(
		url: string,
		options: {
			method?: string
			headers?: Record<string, string> | undefined
			body?: string | Blob | Uint8Array
		}
	): Promise<IFetchResponse>
	wsOpen(url: string): Promise<number>
	wsSend(handle: number, data: string): Promise<void>
	wsGetMessageFromBuffer(handle: number): Promise<string | undefined>
	wsClose(handle: number)
	reset()
}
