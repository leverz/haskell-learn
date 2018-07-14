class MinHeap {
  constructor (arr = []) {
    this.data = arr.slice(0)
    const len = arr.length
    // 从中间位置开始遍历，因为之后的节点一定没有子树
    // 同时能够保证之后的排序结果仍能够影响之前的结果，如果从头开始遍历，后面的无法影响前面的结果
    for (let i = Math.floor(len / 2 - 1); i >= 0; i--) {
      this.down(i, len)
    }
  }

  push (data) {
    this.data.push(data)
    this.up(this.data.length - 1)
  }

  pop () {
    const len = this.data.length
    this.swap(0, len - 1)
    this.down(0, len)
    return this.data.pop()
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

  down (i, len) {
    const l = 2 * i + 1
    const r = l + 1
    let j
    if (l <= len && r <= len) {
      j = this.less(l, r) ? l : r
    } else if (l <= len) {
      j = l
    } else {
      return this
    }
    return this.less(j, i) ? this.swap(i, j).down(j, len) : this
  }

  up (i) {
    const parent = Math.floor((i - 1) / 2)
    if (parent === i || !this.less(i, parent)) {
      return this
    }
    return this.swap(parent, i).up(parent)
  }
}

const heap = new MinHeap([10,5,3,9,11,2,1,6,13])
console.log(heap.data)
heap.push(0)
console.log(heap.data)
heap.pop()
console.log(heap.data)
heap.pop()
console.log(heap.data)
