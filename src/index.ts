export * from './Console'
export * from './DebugConsole'
export * from './VirtualMachine'
export * from './QBasic'
export * from './IAudioDevice'
export * from './AudioDevice'
export * from './INetworkAdapter'
export * from './NetworkAdapter'

import { legacyAPI } from './legacy'
legacyAPI()
