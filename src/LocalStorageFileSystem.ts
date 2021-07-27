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

import { FileAccessMode, IFileSystem } from './IFileSystem'

class LocalStorageFileSystem implements IFileSystem {
	getFreeFileHandle(): number {
		throw new Error('Method not implemented.')
	}
	getUsedFileHandles(): number[] {
		throw new Error('Method not implemented.')
	}
	open(handle: number, fileName: string, mode: FileAccessMode): Promise<void> {
		throw new Error('Method not implemented.')
	}
	close(handle: number): Promise<void> {
		throw new Error('Method not implemented.')
	}
	write(handle: number, buf: string | number | object): Promise<void> {
		throw new Error('Method not implemented.')
	}
	read(handle: number): Promise<string | number | object> {
		throw new Error('Method not implemented.')
	}
	seek(handle: number, pos: number): Promise<void> {
		throw new Error('Method not implemented.')
	}
	eof(handle: number): Promise<boolean> {
		throw new Error('Method not implemented.')
	}
	list(fileSpec: string): Promise<string[]> {
		throw new Error('Method not implemented.')
	}
	kill(fileSpec: string): Promise<void>[] {
		throw new Error('Method not implemented.')
	}
}
