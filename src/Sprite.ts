export class Sprite {
	private _x: number = 0
	get x(): number {
		return this._x
	}

	private _y: number = 0
	get y(): number {
		return this._y
	}

	private _frames: number = 1
	get frames(): number {
		return this._frames
	}

	private _scaleX: number = 1
	get scaleX(): number {
		return this._scaleX
	}

	private _scaleY: number = 1
	get scaleY(): number {
		return this._scaleY
	}

	private _rotation: number = 0
	get rotation(): number {
		return this._rotation
	}

	private _anchorX: number = 0
	get anchorX(): number {
		return this._anchorX
	}
	private _anchorY: number = 0
	get anchorY(): number {
		return this._anchorY
	}

	private _el: HTMLDivElement

	private _pAspectX: number = 1
	private _pAspectY: number = 1
	private _frameWidth: number = 0
	private _imgWidth: number = 0
	private _imgHeight: number = 0

	// Internally, frames are 0-indexed, but BASIC sprite frames are 1-indexed
	private _curFrame: number = 0
	private _totalFrames: number = 0
	private _beginFrame: number = 0
	private _endFrame: number = 0

	private _animDirection: number = 1
	private _animating: boolean = false
	private _loop: boolean = false

	private _display: boolean = true
	get display(): boolean {
		return this._display
	}

	private _loaded: Promise<void>
	get loaded(): Promise<void> {
		return this._loaded
	}

	/**
	 *
	 * @param image Image to be used for the sprite
	 * @param frames Number of frames in sprite
	 * @param pAspectX Display (BASIC Console) pixel X aspect ratio
	 * @param pAspectY Display (BASIC COnsole) pixel Y aspect ratio
	 */
	constructor(image: HTMLImageElement, frames: number, pAspectX: number, pAspectY: number) {
		this._pAspectX = pAspectX
		this._pAspectY = pAspectY
		this._totalFrames = frames
		this._endFrame = frames - 1
		this._el = document.createElement('div')
		this._el.style.position = 'absolute'
		this._el.style.top = '0'
		this._el.style.left = '0'
		this._loaded = new Promise<void>((resolve, reject) => {
			const url = image.src
			this._el.style.backgroundImage = `url('${url}')`
			this._imgHeight = image.naturalHeight
			this._imgWidth = image.naturalWidth
			this._frameWidth = image.naturalWidth / frames
			this._el.style.height = `${image.naturalHeight * this._pAspectY}px`
			this._el.style.width = `${this._frameWidth * this._pAspectX}px`
			this._el.style.backgroundSize = `${this._imgWidth * pAspectX}px ${this._imgHeight * pAspectY}px`
			this.reposition()
			this.bkgReposition()
			resolve()
		})
	}

	update() {
		if (this._animating) {
			const oldFrame = this._curFrame
			this._curFrame = Math.max(Math.min(this._curFrame + this._animDirection, this._totalFrames - 1), 0)
			if (this._curFrame > this._endFrame) {
				if (this._loop) {
					this._curFrame = this._beginFrame
				} else {
					this._curFrame = this._endFrame
					this._animating = false
				}
			} else if (this._curFrame < this._beginFrame) {
				if (this._loop) {
					this._curFrame = this._endFrame
				} else {
					this._curFrame = this._beginFrame
					this._animating = false
				}
			}
			if (oldFrame === this._curFrame) this._animating = false
			this.bkgReposition()
		}
	}

	private bkgReposition() {
		this._el.style.backgroundPosition = `-${this._curFrame * this._frameWidth}px 0`
	}

	private reposition() {
		this._el.style.transformOrigin = `${this._anchorX * this._pAspectX}px ${this._anchorY * this._pAspectY}px`
		this._el.style.transform = `translate(-${this._anchorX * this._pAspectX}px, -${this._anchorY *
			this._pAspectY}px) translate(${this._x * this._pAspectX}px, ${this._y * this._pAspectY}px) rotate(${
			this._rotation
		}deg)`
	}

	setPosition(x: number, y: number) {
		this._x = x
		this._y = y
		this.reposition()
	}

	setScale(scaleX: number, scaleY: number) {
		this._scaleX = scaleX
		this._scaleY = scaleY
		this.reposition()
	}

	setRotate(angle: number) {
		this._rotation = angle
		this.reposition()
	}

	setAnchor(anchorX: number, anchorY: number) {
		this._anchorX = anchorX
		this._anchorY = anchorY
		this.reposition()
	}

	setDisplay(display: boolean) {
		this._display = display
		this._el.style.visibility = display ? 'visible' : 'hidden'
	}

	getElement(): HTMLDivElement {
		return this._el
	}

	setAnimate(startFrame: number, endFrame: number, loop: boolean) {
		this._beginFrame = startFrame
		this._endFrame = endFrame
		this._loop = loop
		this._animating = true
		this._animDirection = this._beginFrame <= this._endFrame ? 1 : -1
	}
}
