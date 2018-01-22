function longer (as, bs) {
  return as.length > bs.length ? as : bs
}

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
const lcs = memoize((xs, ys) => {
  if (xs.length === 0 || ys.length === 0) {
    return ''
  }
  const [x, ..._xs] = xs
  const [y, ..._ys] = ys
  return x === y
    ? [x, ...lcs(_xs, _ys)].join('')
    : longer(lcs(_xs, ys), lcs(xs, _ys))
})

console.log(lcs('find the lights', 'there are four lights'))
