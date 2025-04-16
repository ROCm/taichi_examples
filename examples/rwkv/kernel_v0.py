import taichi as ti

@ti.kernel
def timex_taichi_forward(out: ti.types.ndarray(ndim=3),
        w: ti.types.ndarray(ndim=2),
        k: ti.types.ndarray(ndim=3),
        B: ti.i32, C: ti.i32, T: ti.i32, eps: ti.f32):
    for b, c, t in out:
        s = eps
        for u in range(0, t+1):
            s += w[c, (T-1)-(t-u)] * k[b, c, u]
        out[b, c, t] = s

@ti.kernel
def timex_taichi_backward(
        w: ti.types.ndarray(ndim=2),
        k: ti.types.ndarray(ndim=3),
        gwk: ti.types.ndarray(ndim=3),
        gw: ti.types.ndarray(ndim=3),
        gk: ti.types.ndarray(ndim=3),
        B: ti.i32, C: ti.i32, T: ti.i32):
    for b, c, t in gwk:
        s = 0.0
        for u in range(0, t+1):
            s += gwk[b, c, (T-1)-(t-u)] * k[b, c, u]
        gw[b, c, t] = s
        s = 0.0
        for u in range(t, T):
            s += gwk[b, c, (T-1)+(t-u)] * w[c, u]
        gk[b, c, t] = s
