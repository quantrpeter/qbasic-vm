export interface IAudioDevice {
	beep(num: number): Promise<void>
	setBeep(num: number, data: string | Blob): Promise<void>
	clearBeep(num: number): void

	playMusic(str: string, repeat?: number): Promise<void>
	stopMusic(): void
	isPlayingMusic(): boolean
	makeSound(
		frequency: number,
		duration: number,
		volume?: number
	): Promise<void>
}
