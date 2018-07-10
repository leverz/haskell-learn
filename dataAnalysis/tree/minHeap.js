class MinHeap {
  constructor (arr = []) {
    this.data = arr.slice(0)
    const len = arr.length
    for (let i = len / 2 - 1; i >= 0; i--) {
      this.down(i, len)
    }
  }

  push (data) {
    this.data.push(data)
    this.up(this.data.length - 1)
  }

  pop () {

  }

  remove () {

  }

  fix () {

  }
  
  swap (i, j) {
    if (i >= this.data.length || j >= this.data.length) {
      return this
    }
    const temp = this.data[i]
    this.data[i] = this.data[j]
    this.data[j] = temp
    return this
  }

  less (i, j) {
    return this.data[i] < this.data[j]
  }

  static down (i, len) {
    const l = 2 * i
    const r = 2 * i + 1
    let j
    if (l <= len && r <= len) {
      j = this.less(left, right) ? l : r
    } else if (l <= len) {
      j = l
    } else {
      return this
    }
    return this.swap(i, j).down(j, len)
  }
  static up (i) {
    if (i === 1) {
      return this
    }
    const center = Math.floor(i / 2)
    if (this.less(i, center)) {
      return this.swap(i, center).up(center)
    }
    return this
  }
}