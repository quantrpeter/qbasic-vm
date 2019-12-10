import { Console } from './Console'
import { DebugConsole } from './DebugConsole'
import { VirtualMachine } from './VirtualMachine'
import { QBasicProgram } from './QBasic'

export function legacyAPI() {
	if (window) {
		// @ts-ignore
		window['qb'] = {
			Console,
			DebugConsole,
			VirtualMachine,
			QBasicProgram
		}
	}
}
