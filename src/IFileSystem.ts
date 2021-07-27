export enum FileAccessMode {
	INPUT = 'I',
	OUTPUT = 'O',
	APPEND = 'A',
	RANDOM = 'R',
	BINARY = 'B'
}

export interface IFileSystem {
	getFreeFileHandle(): number
	getUsedFileHandles(): number[]
	open(handle: number, fileName: string, mode: FileAccessMode): Promise<void>
	close(handle: number): Promise<void>
	write(handle: number, buf: string | number | object): Promise<void>
	read(handle: number): Promise<string | number | object>
	seek(handle: number, pos: number): Promise<void>
	list(fileSpec: string): Promise<string[]>
	kill(fileSpec: string): Promise<void>[]
}
