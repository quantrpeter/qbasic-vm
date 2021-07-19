export interface IConsole {
	x: number
	y: number
	reset(testMode?: boolean): void
	record(str: string): void
	getRecorded(): string
	printError(str: string): void
	setKeyBuffer(str: string): void
	screen(num: number): boolean
	line(x1: number, y1: number, x2: number, y2: number, color?: number): void
	lineTo(x: number, y: number, color?: number): void
	circle(
		x: number,
		y: number,
		radius: number,
		colour?: number,
		start?: number,
		end?: number,
		aspect?: number,
		fill?: boolean,
		step?: boolean,
	): void
	box(x1: number, y1: number, x2: number, y2: number, color?: number): void
	fill(x1: number, y1: number, x2: number, y2: number, color?: number): void
	triangleFill(x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, color?: number): void
	getPixel(x: number, y: number): [number, number, number]
	putPixel(x: number, y: number, color: [number, number, number])
	get(x1: number, y1: number, x2: number, y2: number, step1?: boolean, step2?: boolean): ImageData
	put(data: ImageData, x: number, y: number): void
	paint(x: number, y: number, colour: number, borderColor: number, step?: number): void
	putImage(
		image: HTMLImageElement,
		dx: number,
		dy: number,
		dwidth?: number,
		dheight?: number,
		sx?: number,
		sy?: number,
		swidth?: number,
		sheight?: number
	): void
	cls(): void
	locate(row: number, col: number): void
	color(fg: number | null, bg: number | null, bo: number | null): void
	scroll(): void
	input(): Promise<string>
	onKey(num: number, handler: (() => void) | undefined): void
	backup(num): void
	onKeyDown(event: KeyboardEvent): void
	getKeyFromBuffer(): number
	enableCursor(enabled: boolean): void
	toggleCursor(): void
	cursor(show: boolean): void
	newline(): void
	print(str: string): void

	loadImage(url: String): Promise<number>
	getImage(handle: number): HTMLImageElement
	clearImage(handle: number): void

	createSprite(spriteNumber: number, image: HTMLImageElement, frames: number): Promise<void>
	clearSprite(spriteNumber: number)
	offsetSprite(spriteNumber: number, x: number, y: number)
	scaleSprite(spriteNumber: number, scaleX: number, scaleY: number)
	homeSprite(spriteNumber: number, homeX: number, homeY: number)
	displaySprite(spriteNumber: number, display: boolean)
	rotateSprite(spriteNumber: number, angle: number)
	animateSprite(spriteNumber: number, startFrame: number, endFrame: number, speed?: number, loop?: boolean)
}
