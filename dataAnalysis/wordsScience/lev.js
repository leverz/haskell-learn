function memoize (func) {
  const cache = {}
  return (...args) => {
    if (cache[args]) {
      return cache[args]
    }
    cache[args] = func(...args)
    return cache[args]
  }
}

// 用了 memoize 效果相当明显，之前没加这个会跑好久都算不出结果
const lev = (xs, ys) => {
  const ind = (i, j) => xs[i - 1] === ys[j - 1] ? 0 : 1
  const _lev = (i, j) => {
    if (Math.min(i, j) === 0) {
      return Math.max(i, j)
    }
    return Math.min(1 + levM(i - 1, j), 1 + levM(i, j - 1), ind(i, j) + levM(i - 1, j - 1))
  }
  const levM = memoize(_lev)
  return levM(xs.length, ys.length)
}

console.log(lev('find the lights', 'there are four lights'))
console.log(lev('abc', 'abe'))
console.log(lev('mercury', 'sylvester'))
