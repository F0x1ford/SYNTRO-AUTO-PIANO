--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_OR = obf_bitlib.bor;
local obf_AND = obf_bitlib.band;
local Players = game:GetService("Players");
local UIS = game:GetService("UserInputService");
local VIM = game:GetService("VirtualInputManager");
local TweenService = game:GetService("TweenService");
local StarterGui = game:GetService("StarterGui");
local Player = Players.LocalPlayer;
local PlayerGui = Player:WaitForChild("PlayerGui");
local old = PlayerGui:FindFirstChild("SynTroAutoPiano");
if old then
	old:Destroy();
end
local BPM = 120;
local Loop = false;
local Playing = false;
local Paused = false;
local StopRequested = false;
local Sheet = "";
local ActiveKeys = {};
local LoadedFromLibrary = false;
local CurrentTab = "LIBRARY";
local minimized = false;
local LibrarySongs = {{title="If I Am With You – Jujutsu Kaisen",bpm=110,sheet=[=[

i p a s a p
i p a s a p
i p a s a p
i p a s a p
u o a [sk] a o
u o a d a o
u o a [dk] a o
u o a f a o
y p s [hk] s p
y p s h s p
y p s [hk] s p
y p s h s p
t o f [kz] f o
t o f k f o
t o f [kz] f o
t o f l f o
[iz] p [aj] s [ak] p
[il] p a s a p
[iz] p [aj] s [ak] p
[il] p a [sk] [aj] p
[uz] o [ah] s [aj] o
[uk] o a d a o
[uz] o [ah] f [aj] o
[uk] o a [fj] [ah] o
[yz] p [sh] h [sj] p
[yk] p s h s p
[yz] p [sh] h [sj] p
[yk] p s [hj] [sz] p
[thv] o [gc] h [gz] o
[tk] o d h d o
t o f k f o
[tkz] o f [klv] f o
[4l] 8 0 s [ef] f
[qf] t y p [ed] f
[qh] t u p [td] p
[qs] t u o y
1 5 [8hk] [0l] [rk] w
[8of] w r u [rd] w
[8od] w r y [uf] [yh]
[uh] t y o s t
[^f] h l q e [Ed] i z
[thl] E s t f [qd]
[9ph] q e t [dg] 0
[qsf] e t u o y
[wu] t [yfk] [tl] [yk] o
d a t y d
[0s] e y o u
w r [uf] [ok] [pzv]
t i p f b g
g b f [gb]
[ps] j b k
l b k [hm]
[sfv] v
x d v
v z
[4sfl] 8 0 e 0 d h k
h g d [adz] o i y r [fx] 9
[4fx] 8 0 o a o
[8lm] [wkn] e [fx] q [dz]
[1ahk] 5 [8a] [0s] [wa] [yo]
[8y] w [rgjc] y [fhx]
[7dgz] q e r y x
[H3sl] 7 9 W t O s O t
[6toa] 0 [esl] e [tdz] u
[ef] j l t x [okn] r [tlm] 9
[5h] l z v 9 w r t h
[wl] [yh] [ol] c r x
[4fjx] 8 q w e [tx]
[qjz] [tl] i w e l
[2jv] 6 9 0 q e
[9vn] [qk] [ex] [tb] [0v] [qs]
[6lxbm] 8 0 [wsf] e t
q w [tf] h z e [wk] q
[7ofh] 0 w r u o
[wa] u f h k
[qm] u n [am] v s m
h g f
[tm] u O n m [sv] m
d m v a

]=]},{title="Golden Hour",bpm=94,sheet=[=[

[dq] g h j h f [dq] g h j h f [dq] g h j h f [dq] g h j h f
[s0] f h j h f [s0] f h j h f [s0] f h j h f [s(] f h j h f
[s9] d g h g d [s9] d g h g d [s9] d g h g d [s9] d g h g d
[a8] s d f d s [a8] s d f d s [a8] s d f d s [a8] s d f d s
[uq] u u u u y q [uq] u u u u [uq] u u u
[u0] u u u u y 0 [u0] u u u [u(] u u u u
[y9] t u y u y 9 [u9] y u y u y 9 t
[u8] u u u u [u8] u u u u [u8] u u y t 8 u o [p4]
u p a s 4 | u p a [a0] p o [oy]
u [a0] p o [a(] p o [o9] i t
9 t [oe] i u [u0] 0 0 [p0] 0 0 [s0] 0 0 d
[f4] 0 t q [p4] [a0] [hu] [gy] [f8]
r u d t p s [a8]
[ay] [s2] [d3] [f4] 0 t q
[p4] [a0] [hu] [gy] [f8] r u t p s [a8] y [P2] [P3]
[uq] u u u u y q [uq] u u u u [uq] u u u
[u0] u u u u y 0 [u0] u u u [u(] u u u u
[y9] t u y u y 9 [u9] y u y u y 9 t
u 8 u u u y y u 8 u u u y y u 8 u u y t t u o p 4
u p a s 4 u p a a 0 p o o y u a 0 p o a ( p o o 9 i t
9 t [oe] i u u 8 r [u8] u u y t r u o [p4]
u p a s 4 | u p a [a0] p o [oy] | u [a0] p o [a(] p o [o9] i
9 t [oe] i u [u0] 0 0 [p0] 0 0 [s0] 0 0 d [f4]
0 t q [p4] [a0] [hu] [gy] [f8]
r u d t p s [a8] [ay] [s2] [d3] [f4]
0 t q [p4] [a0] [hu] [gy] [f8]
r u t p s [a8] y [P2] [P3]
[ft] w w w w p w a w [ht] w g w [fr] r r
[ar] s d f d s a s d f d s a
[s1] d f | d f h j h f [du] f h j h f [dy] f h j h f
[pt] a h W g f 1
a s d f d s a s d f d s [ay] s d [fu] d s [ai] s d [fu] d s
a s d f d s P s d f d s P s d f d s [ft]
s p | [fr] a o | [dE] P p i [de] P p
[sw] o s f y G e y p s d p G d j

]=]},{title="River Flows In You - Yiruma",bpm=145,sheet=[=[
[el] [uk] [pl] k [ql] [th] [ol] g
s f
[el] [uk] [pl] k [ql] [th] [ol] g
s f
[el] [uk] l p s k l q s [th] l o s [qg] s
[8d] f [wg] [ush] f [wad] y o s a
[es] u p o s d [qf] t o f g
[8h] w u g f [wd] y a
[es] f l [uk] l p s k l q s [th] l o s [qg] s
[8d] f [wg] [uh] [8x] [wz] [yh] [oz] x z l k
[ehl] u p s d [qf] [yo] [os] f g
[8h] [wo] [uf] g f [wd] y [ol] z l k
[el] s [uh] s [pl] z [el] k [ql] s [th] s [ol] z [ql] k
[8l] z [wx] c [uv] x [8z] l [wk] [yd] [ol] z [wl] k
[el] s [uh] s [ol] z [el] k [ql] s [yh] s [ol] z [ql] k
[8l] z [wx] c [uv] x [8z] l [wk] [yd] [ol] l z [wl] k
[6l] s [0h] s [el] l z [6l] k [ql] s [th] s [ul] l z [ql] k
[8l] z [wx] c [uv] x [8z] l [5k] [9d] [rl] l z [5l] k
[6l] s [0h] s [el] l z [6l] k [ql] s [th] s [ol] z [ql] k
[8l] z [wx] c [uv] x [8z] l [5k] [9d] [ra] o s f
[el] [uk] l p s k l q s [tk] l o s [qg] s
[8d] f [wg] [ush] [8f] [wad] y o s a
[eos] u [os] o s d [qf] o [ts] d [if] o f g
[8h] o [wf] g [uh] o [8g] f [wd] o [yg] f [od] a
[ef] l [uk] l p s [ek] l q s [th] l o s [qg] s
[8d] f [wg] [uh] [8x] [wz] [yh] [oh] x z [wl] k
[ehl] u p s d [qf] o [ts] d [if] o [qf] g
[8h] o [wf] g [uh] o [8g] f [5d] o [9a] d [rl] z [5l] k
[6l] s [0h] s [pl] l z [el] k [ql] s [th] s [ol] l z [ql] k
[8l] z [wx] c [uv] x [8z] x z l [5k] s [9h] s [rl] l z [5l] k
[6l] s [0h] s [pl] l z [el] k [ql] s [th] s [ol] l z [ql] k
[8l] z [wx] c [uv] x [8z] x z l [5k] s [9h] s [rl] l z [5l] k
[6l] s [0h] s [pl] z [el] k [ql] s [th] s [ol] l z [ql] k
[8l] z [wx] c [uv] x [8z] l [5k] [9d] [rl] l z [5l] k
[6l] s [0h] s [pl] l z [el] k [ql] s [th] s [ol] l z [ql] k
[8l] z [wx] c [uv] x [8z] l [5k] [9d] [ra] o
[eus] f l k l k [wsfl] [ih] [pl] [wg]
[wsf] [ug] [tsh] f [oad] s a
[6u] o s 0 o s d [qf] [to] [os] f g
[8h] [wo] [uf] g f [wd] y o s f
[el] [uk] [pl] k [qs] h l [th] [ol] [qg]
[8d] f [wg] [uh] x [whz] y a s
[6os] 0 e s d [qf] [to] [is] f g
[8h] [wo] [us] g f [5d] 9 [ro]
[6s] [0t] [eu] p [usl]
 ]=]},{title="Love story - Indila",bpm=96,sheet=[=[

6 - [etu] - [etu] -
3 - [0wr] - [0wr] -
4 - [qet] - [qet] -
5 - [wry] - [wry] -
6 - [etu] - [etu] -
3 - [0wr] - [0wr] -
4 - [qet] - [qet] -
5 - [wry] - [wry] -
[6fx] - [etu] - [etu] -
[3dz] - [0wr] - [0wr] -
[4pj] - [qet] - [qet] -
[5pj] [ak] [wrysl] - [wryak] -
[6pj] - [etu] - [etu] -
[3oh] - [0wr] [uf] [0wroh] [ak]
[4pj] - [qet] - [qet] -
5 - [wry] - [wry] -
[6fx] - [etu] - [etu] -
[3dz] - [0wr] - [0wr] -
[4pj] - [qet] - [qet] -
[5pj] [ak] [wrysl] - [wryak] -
[6pj] - [etu] - [etu] -
[3oh] - [0wr] - [0wr] -
[4pj] - [qet] - [qet] -
[5ak] - [wry] - [wry] -
[6sl] [sl] [etusl] - [etusl] -
[3dz] - [0wr] - [0wr] -
[4sl] [ak] [qetsl] - [qetak] -
[5pj] - [wry] - [wry] -
[6sl] [sl] [etusl] - [etusl] -
[3dz] - [0wr] - [0wr] -
[4sl] [sl] [qetsl] - [qetpj] -
[5sl] - [wry] - [wry] -
[6sl] [sl] [etusl] - [etusl] -
[3dz] - [0wr] - [0wrak] -
4 - [qetsl] [ak] [qetsl] [ak]
[5pj] - [wry] - [wryoh] -
[6pj] - [etu] - [etu] -
3 - [0wr] - [0wr] -
4 - [qet] - [qet] -
5 - [wry] - [wry] -
[6fx] - [etup] a [etus] p
[3dz] - [0wro] p [0wra] s
[4pj] - [qet] - [qet] -
[5pj] [ak] [wrysl] - [wryak] -
[6pj] - [etuf] j [etul] x
[3oh] - [0wr] f [0wrh] k
[4pj] - [qet] - [qet] -
5 - [wrypj] - [wrypj] -
[6fx] - [etu] c [etux] z
[3sl] - [0wr] z [0wrl] k
[4pj] - [qet] - [qet] -
[5pj] [ak] [wrysl] - [wryak] [pj]
[6oh] - [etu] - [etu] -
3 - [0wr] - [0wruf] -
[4pj] - [qetu] o [qetp] s
[5ak],
[wrysl],

[wrydz],
[6sl] [sl] [etusl] - [etusl] -
[3dz] - [0wr] - [0wr] -
[4sl] [ak] [qetsl] - [qetak] -
[5pj] - [wry] - [wry] -
[6sl] [sl] [etusl] - [etusl] -
[3dz] - [0wr] - [0wr] -
[4sl] [sl] [qetsl] - [qetpj] -
[5sl] - [wry] - [wryak] -
[6sl] - [etusl] [sl] [etusl] -
[3dz] - [0wr] {uiopak0wr},
4 - [qetsl] [ak] [qetsl] [ak]
[5p] - [wry] - [wryoh] -
[6pj] - [etu] - [etu] -
3 - [0wr] - [0wr] -
4 - [qetuf] - [qetoh] -
[5ak] - [wrypj] - [wry] [oh]
[e6uf] - [etu] - [etu] -
[83] - [0wr] - [0wr] -
[94] - [qetfx] - [qethv] -
[q5kn] - [wryjb] - [wry] [hv]
[e6pj] - [etu] - [etu] -
[3] - [0wr] - [0wr] -
[94] - [qetuf] - [qetoh] -
[q5ak] - [wrypj] - [wry] [oh]
[e6fx] - [etu] - [etu] -
[3dz] - [0wr] - [0wr] -
[4pj] - [qet] - [qet] [pj]
[5pj] - [wryoh] - [wry] [oh]
[6pj] - [etu] - [etu] -
3 - [0wr] - [0wr] -
4 - [qet] - [qet] -
5 - [wry] - [wry] -
[6s]-[0f]-j-x...
[3u]-[7p]-[wd]...
[4r]-[8u]-[ep]...
[59wp] a s - a -
[6t]-[0u]-p-f...
[3u]-{7p}-{wd}, u o a
[4r]-[8u]-[ep]...
[48e] - [pfj] [48e] [pfj] -
[e6fx] - [etu] - [etu] -
[3dz] - [0wr] - [0wr] -
[4pj] - [qet] - [qet] -
[5pj] [ak] [wrysl] - [wryak] -
[6pj] - [etufx] - [etupj] -
[3ak] - [0wrfx] - [0wrak] -
[4sl] - [qetfx] - [qetsl] -
[5dz] - [wrysl] [dz] [wrysl] [ak]
[e6pj] - [etufx] - [etupj] -
[83ak] - [0wrfx] - [0wrak] -
[94sl] - [qetfx] - [qetsl] -
[q5dz] - [wrysl] [dz] [wrysl] [ak]
[pj]-
e -
[ps] - [ps] - 0 -
[oa] - {oa} - q - [ip] - [ip] - w - [oa] -
[oa] - e - [ps] - {sp} - 0 - {oa} -
[oa] - q - [ip] - {pi} - w - [oa] -
{oa} - e - [ps] - [ps] - 0 - [oa] - {oa} -
q - [ip] - [ip] - w - {oa} - [oa] -
e - [ps] - [ps] - 0 - {oa} - [oa] - q -
[ip] - [ip] - w - {oa} - [oa] - [6f] -
[et] - [et] - [3d] - [wr] - [wr] - {p4} -
[qe] - [qe] - [5p] a [wrs] - [wra] - [6p] - [et] -
[et] - {o3} - {wr} u [wro] a [4p] - [qe] -
[qe] - 5 - {wr} - {rw} - {f6} - [et] f {g6et}
f [3d] - {wr} f {dwr} - {p4} - [qe] - [qe] -
[5p] a [rs] - [wra] - [6p] - [et] - {et6} p
o-3 - {wr} - [wr] - {p4} - [qe] - [qe] - [5a] -
[wr] - [wr] - [6s] - [ets] - {ets6} - [3d] -
{wr} - [wr] - {s4} d s-[qe] - {aqe} - {p5} - [wr] -
[wr] - [6s] a {ste} - {s6et} - [3d] - {wr} -
[wr] - {s4} a {sqe} - [qea] - {5s} - [wr] -
[wr] - [6s] a [ets] - [ets] - [3d] - [wr] - [wra] -
4 - p-[qe] a {sqe} a {p5} - [wrpa] - [wru] o
[6p] - {et} - [et] - 3 - [wr] - [wr] -
4 - [qe] - [qe] - 5 - {wr} - [wr] - [6f] -
[et] - [et] - {d3} - [wr] - [wr] - [4p] -
[qe] - [qe] - [5p] a [wrs] - [wra] - {6p} - [et] -
[et] - [3o] - {wr} u-{wro} a [4p] - [qe] -
[qe] - 5 - {wpr} - {pwr} - [6f] - [et] - {te} -
[3d] - [wr] - w - [4p] - [qe] - [qe] -
[5p] a [wrs] - [wra] p {6o} - [et] - {et6} -
3 - {wr} - [wru] - {p4} - [qe] - [qe] - [5a] -
{wr} - [wr] - [6s] - [ets] - {e6ts} - [3d] -
{wr} - [wr] - [4s] d [qes] - [qea] - [5p] - {rw} -
[wr] - [6s] a {set} - {est} - [3d] - [wr] -
[wr] - {s4} a {sqe} - [qep] - {s5} - [wr] -
[wr] - {s6} a {s6et} - {ets6} - [3d] - {wr} - [wra] -
4 - [qep] a [6qes] a 5-p {wrap} - [wru] o
{6p} - [et] - [et] - 3 - [wr] - [wr] - 4 -
{qu6e} - [qeo] - [5a] - {pwr} - [wr] o [6u] -
[et] - [et] - 3 - [wr] - [wr] - 4 -
[qeu] - [qeo] - [5a] - [wrp] - [wr] o [6p] - {et} -
[et] - 3 - [wr] - [wr] - 4 - [qef] -
{hqe} - [5k] - [wrj] - [wrh] - {f6} - [et] - {et6} -
{3d} - [wr] - [wr] - [4p] - [qe] - [qe] -
[5o] p [wro] - [wr] u [6p] - [et] - [et] -
3 - [wr] - [wr] - [4t] - [qe] - [qe] - 5 -
[wr] - [wr] - [6f] - {et} - [et] - {3d} -
[wr] - {rw} - [4p] - [qe] - [qe] - {5p} a {wrs} -
[wra] - [6p] - [et] - [et] - [3o] - [wr]
u [wro] a [4p] - {eq} - [qe] - 5 - [wr] -
[wr] - [6f] - [et] - [et] - [3d] - {wr} f {dwr} -
[4p] - [qe] - {eq} - [5pa] a [wrs] - [wra] -
[6p] - [et] - [et] - {3o} - [wr] - {wru} - [4p] -
[qe] - [qe] - {5a} - {wr} - [wr] - {o6} p
[ets] - [ets] - [3d] - {wr} - {awr} - 4 -
[qes] a {eqs} a [5p] - [wr] o [wr] - [6u] - {eto}
p [ets] - {3d} - [wr] - [wra] - 4 - {equ} o
[qep] a {5p} - {wr} - [wra] - [6s] - {eat} p [eta]
s {3d} - [wr] - [wra] - 4 - {qes} a [qe] a
[5p] - [wra] p {wro} - {6p} - [et] - [et] -
3 - [wr] - [wr] - 4 - [qe] - {eq} - 5 -
[wr] - {rw} - [6p] a [ts] s [et] - {3d} -
[wr] a [wr] - 4 - [6qes] a [qes] a [5p] - [wra] -
[wro] - [6p] - {est} a [6ets] - [3d] - [wr] -
[wra] - 4 - {oqe} p {aqe} s {5p} - [wr] -
{wra} - [6s] a {tep} o [etp] s [3d] - [wr] - [wra] -
4 - {sqe} a {sqe} a [5p] - {awr} p [wro] -
{p6} - [et] - [et] o [3s] - [wr] - [wr] - [4d] -
{qed4} - [4qed] - [5k] - {jwr} - [wr] h [6f] -
[et] - {et} - 3 - {wr} - [wr] - 4 -
{qef} - [qeh] - {5k} - [wrj] - [wr] h [6j] - {et} -
[et] - 3 - [wr] - [wr] - 4 - {eqf} -
[eh] - [5k] - {Gjwr} - [wrh] - {f6} - [et] - [et] -
[3d] - [wr] - [wr] - [4p] - [qe] - {qeo} -
5-p - [wro] - [wr] u {6p} - [et] - [et] -
3 - {rw} - {wr} - 4 - [qe] - [qe] - 5 -
[wr] - {rw} - [6f] - [et] - {t6e} - {3d} -
[wr] - {rw} - {4p} - [qe] - [qe] - {5p} a {wrs} -
{wra} - {6p} - [et] - [et] - [3o] - [wr] u
[wro] a [4p] - [qe] - [qe] - 5 - [wr] - [wr] -
[6f] - [et] g {etf} - [3d] - [wr] - [wr] -
[4p] - [qe] - [qe] - [5p] a {wrs} - [wra] -
[6p] - [et] - {t6e} - [3o] - [wr] - [wr] - {4p} -
[qe] - [qe] - [5a] - [wr] - [wra] - 6 -
[ets] a {et6s} - {3d} - [wr] - [wrs] - 4 -
[qes] p [qea] - [5p] - [wr] - [wro] - 6 - {ets}
a-{ets} - {3d} - [wr] - [wra] - 4 - {qeu6} o
[qep] a {5p} - [wr] - [wra] - [6s] - [ets] p [eta]
s [3d] - [wr] - [wra] - 4 - {qes} a {eqs} a
5-p - [wr] p [wro] - [6p] - [et] - [et] -
{3s} - [wr] - [wr] - {4d} - {qed} - [4qed] - {5k} -
[wrj] - [wr] h {f6} - [et] - [et] - 3 -
[wr] - {wr} - 4 - {qef} - {eqh} - [5k] - [wrj] -
[wr] h [6j] - [et] - [et] - 3 - [wr] -
[wr] - 4 - {qef} - {qeh} - 5-k - [wrj] -
[wrh] - [6f] - [et] - [6et] - [3d] - [wr] f [wrd]
s [4p] - [qe] - {qep} - {5o} - [wr] - [wru] -
{6p} - [et] - {et} - 3 - [wr] - [wr] - 4 -
[qe] - [qe] - 5 - [wr] - [wr] - 6 -
[et] - {ety6} - [3u] - [wr] - {owr} - [4f] -
[qe] - [qe] - [5d] - [wr] - [wr] - 6 - {et} -
{et6y} - {3u} - [wr] - {owr} - {4f} - [qe] -
[qe] - [5d] - {wr} - [wr] - 6 - [et] - [6ety] -
[3u] - [wr] - [wro] - [4f] - {qe} - [qe] -
[5d] - [wr] - [wr] - [6p] - [et] - [et] -
[3o] - [wr] - [wr] - [4p] - [qe] - [qe] - {5a} -
[wr] - [wra] - {6s} - [et] - [et] - {3a} -
[wr] - [wr] - [4p] - {eq} - [qe] - 5-a - [wr] -
{rw} - {6s} - [et] d [6ets] - [3a] - [wr] -
{rw} - {4p} - [qe] - [qe] - {o5} - [wr] -
[wr] - {6s} - [et] - [et] - {3a} - {wr} - [wr] -
{4tp} - [qe] - [qe] - [5a] - [wr] - [wr] -
{6s} - [et] - [et] - 3-f - {wru} - {wro} - [4p] -
[qe] - [qe] - 5 - [wr] - {wr} - {6h} -
[et] - {et6} - [3f] - [wr] - [wr] - [4p] -
{eq} - {eq} - 5 - [wr] - [wr] - {h6} - {et} -
[6et] - [3f] - [wr] - [wr] - [4p] - [qe] -
[qe] - 5 - [wr] - [wr] - {6h} - [et] - {te} -
[3f] - {wr} - [wr] - {4p} - [qe] - {eq} -
5 - [wr] - [wr] - {6h} - [et] - {et6} -
{3f} - {wr} - [wr] - {p4q}-
    ]=]},{title="CORNFIELD CHASE",bpm=96,sheet=[=[
        [48qtuipj] x 
[pj] x 
[59wuoak] x 
[ak] x 
[60etupsl] x 
[sl] x 
[59wyuoadz] x 
[dz] x k 
[48qtuipj] x x x x 
j x x x x 
[59wuoak] x x x x 
k x x x x 
[60etupl] x x x x 
l x x x x 
[59wyuoak] x x x x 
k x x x x 
[3tuip] [is] [uf] [ij] [up] [is] [uf] [ij] [up] [is] [uf] [ij] 
[ua] [id] [uf] [ik] [ua] [id] [uf] [ik] [ua] [id] [uf] [ik] 
[ua] [id] [uf] [ik] [ua] [id] [uf] [ik] [ua] [id] [uf] [ik] 
[up] [is] [uf] [ij] [uo] [ia] [uf] [ih] [up] [is] [uf] [ij] 
[ua] [id] [uf] [ik] [ua] [id] [uf] [ik] [ua] [id] [uf] [ik] 
[48qtuipj] i u e [tfx] i u e [tpj] i u e 
[tpj] i u e [tfx] i u e [tpj] i u e 
[50ruoak] o u w [rfx] o u w [rak] o u w 
[rak] o u w [rfx] o u w [rak] o u w 
[60tupsl] i u e [tfx] i u e [tsl] i u e 
[tsl] i u e [tfx] i u e [tsl] i u e 
[48qetuipj] d [qf] g [qj] d [qf] s [qj] d [qf] g 
[48ej] d [4f] g [4j] l [4j] h [4j] d [4f] g 
[59wruoak] d [wf] h [wk] d [wf] s [wk] d [wf] h 
[59rk] d [5f] h [5k] z [5j] h [5k] d [5f] h 
[60etupl] f [ej] k [el] f [ej] s [el] f [ej] k 
[60tl] f [6j] k [6l] x [6k] j [6l] f [6j] k 
[59wryuoaz] f [wh] k [wx] f [wh] a [wz] f [wh] k 
[59rx] f [5h] k [5z] x [5k] h [5x] j [5k] f 
[48qetuipj] d [qf] g [qx] d [qf] s [qj] d [qf] g 
[48ej] d [4f] g [4x] l [4j] h [4j] d [4f] g 
[59wruoak] d [wf] h [wx] d [wf] s [wk] d [wf] h 
[59rk] d [5f] h [5x] z [5j] h [5k] d [5f] h 
[60etupl] f [ej] k [wx] f [ej] s [el] f [ej] k 
[60tl] f [6j] k [6x] x [6k] j [6l] f [6j] k 
[59wryuoaz] f [wh] k [wx] f [wh] a [wz] f [wh] k 
[59rx] f [5h] k [5z] x [5k] h [5x] j [5k] f 
[?4tuip] [6a] [8f] [ea] [8p] [6u] [4p] [6a] [8f] [ea] [8p] [6u] 
[4p] [6a] [8f] [ea] [8p] [6u] [4p] [6a] [8f] [ea] [8p] [6u] 
[?5uoa] [7d] [9f] [wd] [9a] [7u] [5a] [7a] [9f] [wd] [9a] [7o] 
[5a] [7d] [9f] [wd] [9a] [7u] [5a] [7a] [9f] [wd] [9a] [7o] 
[?6tups] [8f] [0f] [ef] [0s] [8p] [6s] [8f] [0f] [ef] [0s] [8p] 
[6s] [8f] [0f] [ef] [0s] [8p] [6s] [8f] [0f] [ef] [0s] [8p] 
[?5yuoad] [9o] [wf] [yd] [wo] [9y] [5d] [9o] [wf] [yf] [wd] [9o] 
[5d] [9o] [wf] [yd] [wo] [9y] [5d] [9o] [wf] [yf] [wd] [9o] 
[?4tuipj] [6d] [8f] [eg] [4x] [6d] [8f] [es] [4j] [6d] [8f] [eg] 
[?4j] [6d] [8f] [eg] [4x] [6l] [8j] [eh] [4j] [6d] [8f] [eg] 
[?5uoak] [7d] [9f] [wh] [5x] [7d] [9f] [ws] [5k] [7d] [9f] [wh] 
[?5k] [7d] [9f] [wh] [5x] [7z] [9j] [wh] [5k] [7d] [9f] [wh] 
[?6tupl] [8f] [0j] [ek] [6x] [8f] [0j] [es] [6l] [8f] [0j] [ek] 
[?6l] [8f] [0j] [ek] [6x] [8x] [0k] [ej] [6l] [8f] [0j] [ek] 
[?5yuoaz] [7f] [9h] [yk] [5x] [7f] [9h] [ya] [5z] [7f] [9h] [yk] 
[?5x] [7f] [9h] [yk] [5z] [7x] [9k] [yh] [5x] [7j] [9k] [yf] 
[?4tuipj] [6d] [8f] [eg] [4x] [6d] [8f] [es] [4j] [6d] [8f] [eg] 
[?4j] [6d] [8f] [eg] [4x] [6l] [8j] [eh] [4j] [6d] [8f] [eg] 
[?5uoak] [7d] [9f] [wh] [5x] [7d] [9f] [ws] [5k] [7d] [9f] [wh] 
[?3fx]
        ]=]},{title="MEGALOVANIA",bpm=120,sheet=[=[
    Trans: -7

e p u Y y t e t y 
w p u Y y t e t y 
Q p u Y y t e t y 
q p u Y y t e t y 
e e p u Y y t e t y 
w w p u Y y t e t y 
Q Q p u Y y t e t y 
q q p u Y y t e t y 
e e p u Y y t e t y 
w w p u Y y t e t y 
Q Q p u Y y t e t y 
q q p u Y y t e t y 
[ep] [ep] [pj] [uf] [YD] [yd] [ts] [ep] [ts] [yd] 
[wo] [pj] [uf] [ep] [ts] [YD] [yd] [ts] [ep] [wo] [QI] 
[pj] [uf] [YD] [yd] [ts] [ep] [ts] [yd] 
[ts] [yd] [uf] [oh] [uf] [oh] [pj] [sl] [pj] 
[pj] [uf] [YD] [yd] [ts] [ep] [ts] [yd] 
o j f p s D d s p o I 
O P S f [Hd] 
[Gs] [Sa] [SD] [dh] [DH] 
[hl] 
[YD] [yd] [ts] [wo] [WO] [ep] [ts] [YD] [ts] [yd] [WO] [yd] [ts] [yd] 
[YD] [ts] [yd] [ts] [ep] [YD] [ts] [yd] [ts] [ep] [YD] [ts] [yd] [ts] [ep] [ts] [ep] [wo] [0u] 
[6etuoa] e 0 ( 9 8 6 8 9 
[5etuo] e 0 ( 9 8 6 8 9 
[QI9eys] e 0 ( 9 8 6 8 9 
[eips] e 0 ( 9 8 e W w Q q 0 ( 9 * 8 7 ^ 
6 [etuopaj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] 
[5wetuo] [epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] 
[QI9eys] [epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [O90rud] 
8 
9 8 5 6 5 
[6euops] s s s s p p 
[E5wios] s s d D [PD8tu] d s p s d 
[Yqetis] s s d D f h f 
[7ripdj] j j f j h [Owrud] Y y t 
[6euopsf] [sf] [sf] [sf] [sf] [pd] [pd] 
[E5wyiosf] [sf] [sf] [sf] [pd] [PD8tuo] [sf] [sj] [pf] [od] 
[Yqetisj] f d s h d s a 
[7ripd] o p [OPwrud] a h 
[etips] [etips] [etips] [8etips] [6p] [8etips] [9d] [(D] [9d] [8s] [6p] 
[9wryoad] [6p] [8wryoas] [9d] [9d] [0f] [wryoah] [wryoa] [wryoa] [(D] [0f] 
[weupsfh] [0eupsf] [(D] [9d] [8s] [6p] [7eupasf] [0eupsf] [9eupsdf] [8f] [7h] 
[WYOH6ts] [WYOts] [D6] [7d] [8s] [WYO9tsd] [EPyi] [EPyi] 
[etips] [etips] [6ps] [6ad] [6sf] [6etipsjl] [5etipsgj] [hk] [etips] [5fj] 
[wryoadk] [wryoa] [5fl] [wryoa] [6wryoahz] [wryoa] [7fk] 
[6eupsfjx] [eupsf] [eupsf] [eupsf] Z [eupsfz] L l k J j 
[%WYODHts] [WYOts] [WYOts] [^EPJyig] [EPyi] 
[etips] [etips] [etips] [8etips] [6p] [8etips] [9d] [(D] [9d] [8s] [6p] 
[9wryoad] [6p] [8wryoas] [9d] [9d] [0f] [wryoah] [wryoa] [wryoa] [(D] [0f] 
[weupsfh] [0eupsf] [(D] [9d] [8s] [6p] [7eupasf] [0eupsf] [9eupsdf] [8f] [7h] 
[WYOH6ts] [WYOts] [D6] [7d] [8s] [WYO9tsd] [EPyi] [EPyi] 
[etips] [etips] [6ps] [6ad] [6sf] [6etipsjl] [5etipsgj] [hk] [etips] [5fj] 
[wryoadk] [wryoa] [5fl] [wryoa] [6wryoahz] [wryoa] [7fk] 
[eipsjx] [eips] [eips] [eips] [eips] [eips] [Owruodhzv] 
e W w Q q 0 ( 9 * 8 7 ^ [6ep] [epj] [0uf] 
[8ts] [9yd] [8ts] [6ep] [9yd] [0uf] [5wo] [5wo] [epj] [0uf] [0u] [qi] [6ep] 
[8ts] [0uf] [qig] [5wo] [QI] [QI] [epj] [0uf] [6ep] [9yd] [0uf] [9yd] [8ts] [6ep] [9yd] 
[8ts] [0u] [qi] [8ts] [%WO] [6ep] [0uf] [7ra] [8ts] [woh] [0uf] [WOH] [tsl] [6ep] 
[epj] [0uf] [8ts] [9yd] [8ts] [6ep] [9yd] [0uf] [5wo] [5wo] [epj] 
[0uf] [0u] [qi] [6ep] [8ts] [0uf] [qig] [5wo] [QI] [QI] [epj] [0uf] 
[6ep] [9yd] [0uf] [9yd] [8ts] [6ep] [9yd] [8ts] [0f] 
e W w Q q 0 ( 9 * 8 7 ^ 6 [6euosf] 
6 [%YD] [E5wiopsd] 
[PDtuos] [Yqetsg] 8 
q 8 6 8 [I7ryipad] 6 
[OPwrud] [6euosf] 
6 [%YD] [E5wiopsd] 
[PDtuos] [Yqetsg] 8 
q 8 6 8 [I7ryipad] q 
[OP0wrud] [6euosf] 
6 % [E5wiopsd] 
[PD8tuos] [Yqetsg] 8 
q 8 [I7ripad] 6 
[OPwrud] [6euosf] 
6 % [E5wiopsd] 
[PD8tuos] [Y6qetsg] 8 9 6 
8 9 ( 0 w [Iripad] 8 9 6 
[OP8wrud] ( 0 w r [isg] 
s [5adf] p 
s [Gd] 
t t t t t y 
e r w e [isg] 
s [5adf] p 
o p [6ehj] [ep] [0u] [(Y] 
[9y] [8t] [6e] [8t] [9y] [6e] [ep] [0u] [6e] 
[7r] [8t] [0u] [Yqtipsg] [Yqetps] [Y0qtps] ( 
9 8 [sj] 6 8 9 [5wrupadfh] [werupd] [0wrupd] [pg] ( 
9 8 6 [G8s] 9 [QIG69eysd] [QI9eys] [QI90eys] ( 
9 8 6 8 9 [QI69eys] [QI9eys] [QI90eys] [QI9eys] ( 
[QI9eys] 9 [QI9eys] 8 [QI9eys] [9eyipd] 6 8 9 [Yqtipsg] [Yqetps] [Y0qtps] ( 
9 8 [sj] 6 8 9 [5wrupadfh] [werupd] [0wrupd] [pg] ( 
9 8 6 [8pf] 9 [6euoshj] [euos] [0euos] ( 
9 8 6 8 9 [6euos] e [euos] [0euos] [(euos] 
[euos] 9 [euos] 8 [euos] 6 [8euos] 9 [6ep] [epj] [0uf] [(YD] 
[9yd] [8ts] [5wo] [epj] [0uf] [(YD] [9yd] [8ts] 
[6ep] [epj] [0uf] [8ts] [9yd] [0uf] [9yd] 
[WOH] [qig] [0uf] [9yd] [8ts] [%WO] [6ep] [epj] [0uf] [6ep] 
[uf] [5oh] [6pj] [8sl] [9dz] [0fx] [9dz] [8sl] [5oh] 
[QIG] [ydz] [QIG] [qig] [0uf] [tsl] [0uf] [(YD] [9yd] [rak] [epj] [epj] [WOH] [woh] [QIG] [qig] [0uf] [(YD] [9yd] [*TS] [8ts] [qyd] 
[%Wig] [^Eoh] [qyd] [%Wig] [^Eoh] [OH7r] [0usl] [wofx] [6epj] 
[6ydz] [ufx] [YDZ6] [ydz] [6tsl] [5woh] [5epj] 
[YDZ5] [ufx] [%ohv] [8sl] 8 8 [8p] 
8 8 8 [O9dz] 9 9 9 [9f] 
9 9 9 [6etuos] [euos] [ts] [ts] [euos] [etuos] [ts] [euos] [euops] 
[ep] [euos] [euos] [wo] [ep] [E5wtios] [Ewios] [ts] [ts] [Ewios] [Ewyiosd] [YD] [PDtu] [PDtyud] 
[ts] [ep] [PDtus] [PDtyud] [uf] [Yqets] [Yqet] [ts] [ts] [Yqet] [Yqetyd] [YD] [Yqet] [Yqetuf] 
[oh] [Yqet] [uf] [Yqet] [5ripdj] [ripdj] [ripdj] [ruipdf] [pj] [Owruodh] % 
[6euosf] [euos] [sf] [sf] [euos] [euosf] [sf] [euos] [euopsd] 
[pd] [euos] [euos] [E5wiosf] [Ewios] [sf] [sf] [Ewios] [Ewiosf] [pd] [PDtu] [PDtusf] 
[sj] [PDtu] [PDtupf] [od] [Yqetpj] [Yqet] f [Yqetd] [Yqet] s [Yqetoh] [Yqet] 
d [Yqets] [Yqet] a [qi] [qwo] [wra] [woh] 
[qi] [qo] [wa] [wh] 
[qi] [wo] [ep] [ts] [ra] [wo] [ep] [ts] [yd] [uf] [oh] [pj] 
[ep] 
[ep] 
[pj] 
[uf] 
[YD] [yd] [ts] [ep] [ts] [yd] [wo] [wo] 
[pj] [uf] [YD] [yd] [ts] [ep] [ts] [yd] [QI] [QI] 
[pj] [uf] [YD] [yd] [ts] [ep] [ts] [yd] [qi] [qi] 
[pj] [uf] [YD] [yd] [ts] [ep] [ts] [yd] [6ep] [6ep] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [5wo] [5wo] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [QI] [QI] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [qi] [qi] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [6ep] [ep] 
[6pj] [6uf] 6 [YD6] [6yd] [6ts] [ep] [ts] [yd] [5wo] [wo] 
[5pj] [5uf] 5 [YD5] [5yd] [5ts] [ep] [ts] [yd] [QI] [QI] 
[pj] [uf] [YD] [yd] [ts] [ep] [ts] [yd] [qi] [qi] 
[pj] [uf] [YD5] [5yd] [5ts] [ep] [ts] [yd] [6euops] 
s s s s p p o p [E5wios] 
s s d D [PD8tu] d s p s d [Pqtuis] 
s s d D f h f [7ripdj] 
j j f j h [Owrud] [6euopsf] 
[sf] [sf] [sf] [sf] [pd] [pd] [E5wyiosf] 
[sf] [sf] [sf] [pd] [PD8tuo] [sf] [sj] [pf] [od] [Pqtuipsj] 
f d s [oh] d s a [ripd] 
o [ip] [ps] [ah] [Owrud] [qtips] 
[qtips] [qtips] p s [qtipsd] D d s p [wryod] p 
s [wryod] d f h [wryo] [wryo] D f [eupsh] 
f [Deups] d s p a [eups] d [eups] f h [YOHts] 
[YODts] d s d [Pyid] [Pyid] [qtips] 
[qtips] [ps] [ad] [sf] [jl] [qtipsgj] [hk] [qtips] [fj] [wryodk] 
[wryo] [fl] [wryohz] [wryo] [fk] [eupsjx] 
[eups] [eups] Z z [Leups] l k J j [YODHts] 
[YOts] [PJyidg] [Pyid] [6e] 
[ep] [0u] [(Y] [9y] [8t] [6e] [8t] [9y] [5w] 
[ep] [0u] [(Y] [9y] [8t] [6e] [8t] [9y] Q 
[ep] [0u] [(Y] [9y] [8t] [6e] [8t] [9y] q 
[ep] [0u] [(Y] [9y] [8t] [6e] [8t] [9y] [6ep] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [5wo] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [QI] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [qi] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [6etuopsf] 
j [6etuosf] [D6etuosf] d s p s d [E5wiosdg] 
j [E5wiosfg] [PDtyuf] d s [PDtyuf] p s d [Pqetuis] 
j [Pqetusf] [PDqetus] d s p s d [DG6ryipd] 
d D [G6ryipd] s d [^IOHwrusd] p o [^IOHwrud] p o [6etuopsf] 
j [6etuosf] [D6etuosf] d s p s d [E5wiosg] o 
j [E5wiosfg] s [PD5tyuf] d s [PD5tyuf] p o I [Pqetus] 
j [Pqetusf] [PDqetus] d s d D [G6ryipd] 
d s [G6ryipd] s p u [^IOHwruod] p s [^IOHwrud] p [6ep] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [6ep] 
[epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] [9yd] [6ep] [5wo] 
[6ep] [8ts] [6ep] [5wo] [6ep] [9yd] [8ts] [9yd] [0uf] [woh] [(D] [8s] 
[9d] [8s] [6p] [(D] [8s] [9d] [8s] [6p] [(D] [8s] [9d] [8s] [6p] [(YD] [8ts] [9yd] 
[8ts] [6ep] [(YD] [8ts] [9yd] [8ts] [6ep] [(YD] [8ts] [9yd] [8ts] [(YD] [8ts] [9yd] [0uf] [woh] 
[epj] [tsl] [epj] [0uf] [(YD] [9yd] [8ts] [6ep] [8ts] 
[9yd] [0uf] [6ep] [^EP] [7ra] [8ts] [*TS] [9yd] [(YD] [0uf] [qig] [QIG] [woh] [WOH] [epj]

    ]=]}};
local KeyMap = {};
local letters = "abcdefghijklmnopqrstuvwxyz";
for i = 1, #letters do
	local FlatIdent_DFF4 = 0;
	local char;
	while true do
		if (FlatIdent_DFF4 == 0) then
			char = letters:sub(i, i);
			KeyMap[char] = Enum.KeyCode[char:upper()];
			break;
		end
	end
end
local digitNames = {"Zero","One","Two","Three","Four","Five","Six","Seven","Eight","Nine"};
for i = 0, 9 do
	KeyMap[tostring(i)] = Enum.KeyCode[digitNames[obf_AND(i, 1) + obf_OR(i, 1)]];
end
local SymbolMap = {["!"]=Enum.KeyCode.One,["@"]=Enum.KeyCode.Two,["#"]=Enum.KeyCode.Three,["$"]=Enum.KeyCode.Four,["%"]=Enum.KeyCode.Five,["^"]=Enum.KeyCode.Six,["&"]=Enum.KeyCode.Seven,["*"]=Enum.KeyCode.Eight,["("]=Enum.KeyCode.Nine,[")"]=Enum.KeyCode.Zero,_=Enum.KeyCode.Minus,["+"]=Enum.KeyCode.Equals,["{"]=Enum.KeyCode.LeftBracket,["}"]=Enum.KeyCode.RightBracket,[":"]=Enum.KeyCode.Semicolon,['"']=Enum.KeyCode.Quote,["<"]=Enum.KeyCode.Comma,[">"]=Enum.KeyCode.Period,["?"]=Enum.KeyCode.Slash,["|"]=Enum.KeyCode.BackSlash,["~"]=Enum.KeyCode.Backquote};
local SimpleSymbols = {["-"]=Enum.KeyCode.Minus,["="]=Enum.KeyCode.Equals,["["]=Enum.KeyCode.LeftBracket,["]"]=Enum.KeyCode.RightBracket,[";"]=Enum.KeyCode.Semicolon,["'"]=Enum.KeyCode.Quote,[","]=Enum.KeyCode.Comma,["."]=Enum.KeyCode.Period,["/"]=Enum.KeyCode.Slash,["\\"]=Enum.KeyCode.BackSlash,["`"]=Enum.KeyCode.Backquote};
local function getKey(char)
	local FlatIdent_95CAC = 0;
	while true do
		if (FlatIdent_95CAC == 1) then
			return SimpleSymbols[char], false;
		end
		if (FlatIdent_95CAC == 0) then
			if ((428 < 1804) and KeyMap[char:lower()]) then
				return KeyMap[char:lower()], char ~= char:lower();
			end
			if (SymbolMap[char] or (3325 > 4613)) then
				return SymbolMap[char], true;
			end
			FlatIdent_95CAC = 1;
		end
	end
end
local function releaseAll()
	local FlatIdent_7DFA5 = 0;
	while true do
		if (FlatIdent_7DFA5 == 0) then
			for keyCode in pairs(ActiveKeys) do
				pcall(function()
					VIM:SendKeyEvent(false, keyCode, false, game);
				end);
			end
			ActiveKeys = {};
			break;
		end
	end
end
local function parseToken(token)
	local FlatIdent_28014 = 0;
	local multiplier;
	local keys;
	local shift;
	local result;
	while true do
		if (FlatIdent_28014 == 1) then
			keys = {};
			shift = false;
			FlatIdent_28014 = 2;
		end
		if (FlatIdent_28014 == 0) then
			multiplier = 0.5;
			if (((token:sub(1, 1) == "[") and (token:sub(-1) == "]")) or (4950 <= 4553)) then
				token = token:sub(2, -2);
			else
				local FlatIdent_8D327 = 0;
				local ending;
				while true do
					if (FlatIdent_8D327 == 0) then
						ending = token:sub(-1);
						if ((2665 <= 3933) and (ending == "_")) then
							local FlatIdent_24A02 = 0;
							while true do
								if (FlatIdent_24A02 == 0) then
									multiplier = 2;
									token = token:sub(1, -2);
									break;
								end
							end
						elseif ((ending == "-") or (4593 <= 2672)) then
							local FlatIdent_7126A = 0;
							while true do
								if (FlatIdent_7126A == 0) then
									multiplier = 1;
									token = token:sub(1, -2);
									break;
								end
							end
						elseif (ending ~= ".") then
						else
							multiplier = 0.25;
							token = token:sub(1, -2);
						end
						break;
					end
				end
			end
			FlatIdent_28014 = 1;
		end
		if (FlatIdent_28014 == 3) then
			for key in pairs(keys) do
				table.insert(result, key);
			end
			return result, shift, multiplier;
		end
		if (FlatIdent_28014 == 2) then
			for i = 1, #token do
				local FlatIdent_12703 = 0;
				local key;
				local needsShift;
				while true do
					if (FlatIdent_12703 == 0) then
						key, needsShift = getKey(token:sub(i, i));
						if key then
							keys[key] = true;
							if ((3273 == 3273) and (needsShift or (1168 > 3156))) then
								shift = true;
							end
						end
						break;
					end
				end
			end
			result = {};
			FlatIdent_28014 = 3;
		end
	end
end
local function pressNote(keys, shift)
	local FlatIdent_2BD95 = 0;
	while true do
		if (FlatIdent_2BD95 == 0) then
			if shift then
				VIM:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game);
				ActiveKeys[Enum.KeyCode.LeftShift] = true;
			end
			for _, key in ipairs(keys) do
				local FlatIdent_23BE8 = 0;
				while true do
					if (FlatIdent_23BE8 == 0) then
						VIM:SendKeyEvent(true, key, false, game);
						ActiveKeys[key] = true;
						break;
					end
				end
			end
			break;
		end
	end
end
local function releaseNote(keys)
	local FlatIdent_8199B = 0;
	while true do
		if (FlatIdent_8199B == 0) then
			for _, key in ipairs(keys) do
				local FlatIdent_7E707 = 0;
				while true do
					if (FlatIdent_7E707 == 0) then
						pcall(function()
							VIM:SendKeyEvent(false, key, false, game);
						end);
						ActiveKeys[key] = nil;
						break;
					end
				end
			end
			if ((3824 > 409) and ActiveKeys[Enum.KeyCode.LeftShift]) then
				VIM:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game);
				ActiveKeys[Enum.KeyCode.LeftShift] = nil;
			end
			break;
		end
	end
end
local function playSheet()
	local FlatIdent_32BB2 = 0;
	while true do
		if (FlatIdent_32BB2 == 0) then
			if ((2087 == 2087) and (Playing or (Sheet:gsub("%s", "") == "") or (572 > 4486))) then
				return false;
			end
			Playing = true;
			FlatIdent_32BB2 = 1;
		end
		if (FlatIdent_32BB2 == 2) then
			task.spawn(function()
				local FlatIdent_39B0 = 0;
				while true do
					if (FlatIdent_39B0 == 0) then
						repeat
							local FlatIdent_61585 = 0;
							local tokens;
							while true do
								if (1 == FlatIdent_61585) then
									for _, token in ipairs(tokens) do
										if (((1404 == 1404) and StopRequested) or (3404 > 4503)) then
											break;
										end
										while Paused and not StopRequested do
											task.wait(0.1);
										end
										if (StopRequested or (3748 < 2212) or (3506 <= 1309)) then
											break;
										end
										local keys, shift, multiplier = parseToken(token);
										if (#keys <= 0) then
										else
											local duration = (60 / math.max(BPM, 1)) * multiplier;
											local ok, err = pcall(function()
												pressNote(keys, shift);
												local elapsed = 0;
												while (elapsed < duration) and not StopRequested do
													if Paused then
														task.wait(0.1);
													else
														elapsed += task.wait()
													end
												end
												releaseNote(keys);
											end);
											if ((2955 == 2955) and not ok) then
												warn("SYNTRØ:", err);
												releaseAll();
												StopRequested = true;
												break;
											end
										end
									end
									releaseAll();
									break;
								end
								if (0 == FlatIdent_61585) then
									tokens = {};
									for token in Sheet:gmatch("%S+") do
										table.insert(tokens, token);
									end
									FlatIdent_61585 = 1;
								end
							end
						until not Loop or StopRequested 
						Playing = false;
						FlatIdent_39B0 = 1;
					end
					if (FlatIdent_39B0 == 1) then
						Paused = false;
						releaseAll();
						break;
					end
				end
			end);
			return true;
		end
		if (FlatIdent_32BB2 == 1) then
			StopRequested = false;
			Paused = false;
			FlatIdent_32BB2 = 2;
		end
	end
end
local Gui = Instance.new("ScreenGui");
Gui.Name = "SynTroAutoPiano";
Gui.ResetOnSpawn = false;
Gui.DisplayOrder = 20;
Gui.Parent = PlayerGui;
local function tween(obj, duration, properties, style)
	local animation = TweenService:Create(obj, TweenInfo.new(duration, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties);
	animation:Play();
	return animation;
end
local function makeCorner(obj, radius)
	local FlatIdent_7F35E = 0;
	local corner;
	while true do
		if (1 == FlatIdent_7F35E) then
			corner.Parent = obj;
			break;
		end
		if (FlatIdent_7F35E == 0) then
			corner = Instance.new("UICorner");
			corner.CornerRadius = UDim.new(0, radius);
			FlatIdent_7F35E = 1;
		end
	end
end
local function makeLabel(parent, text, position, size, textSize)
	local FlatIdent_455BF = 0;
	local object;
	while true do
		if (FlatIdent_455BF == 1) then
			object.Position = position;
			object.Size = size;
			FlatIdent_455BF = 2;
		end
		if (FlatIdent_455BF == 0) then
			object = Instance.new("TextLabel");
			object.BackgroundTransparency = 1;
			FlatIdent_455BF = 1;
		end
		if (FlatIdent_455BF == 3) then
			object.Font = Enum.Font.GothamBold;
			object.TextSize = textSize;
			FlatIdent_455BF = 4;
		end
		if (FlatIdent_455BF == 2) then
			object.Text = text;
			object.TextColor3 = Color3.fromRGB(245, 240, 255);
			FlatIdent_455BF = 3;
		end
		if (FlatIdent_455BF == 4) then
			object.Parent = parent;
			return object;
		end
	end
end
local function makeButton(parent, text, position, size, color, textSize)
	local FlatIdent_7A75F = 0;
	local object;
	while true do
		if (FlatIdent_7A75F == 2) then
			object.Font = Enum.Font.GothamBold;
			object.TextSize = textSize or 13;
			object.BorderSizePixel = 0;
			FlatIdent_7A75F = 3;
		end
		if (FlatIdent_7A75F == 0) then
			object = Instance.new("TextButton");
			object.Position = position;
			object.Size = size;
			FlatIdent_7A75F = 1;
		end
		if (FlatIdent_7A75F == 1) then
			object.BackgroundColor3 = color;
			object.Text = text;
			object.TextColor3 = Color3.new(1, 1, 1);
			FlatIdent_7A75F = 2;
		end
		if (FlatIdent_7A75F == 4) then
			return object;
		end
		if (FlatIdent_7A75F == 3) then
			object.AutoButtonColor = false;
			object.Parent = parent;
			makeCorner(object, 8);
			FlatIdent_7A75F = 4;
		end
	end
end
local Main = Instance.new("Frame");
Main.Name = "Main";
Main.Size = UDim2.fromOffset(560, 330);
Main.Position = UDim2.new(0.5, -280, 0.5, -165);
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 30);
Main.BorderSizePixel = 0;
Main.ClipsDescendants = true;
Main.Parent = Gui;
makeCorner(Main, 13);
local Stroke = Instance.new("UIStroke");
Stroke.Color = Color3.fromRGB(135, 90, 220);
Stroke.Thickness = 1.4;
Stroke.Parent = Main;
local Header = makeLabel(Main, "SYNTRØ ツ", UDim2.fromOffset(14, 7), UDim2.fromOffset(170, 25), 16);
Header.TextXAlignment = Enum.TextXAlignment.Left;
local Subtitle = makeLabel(Main, "AUTO PIANO", UDim2.fromOffset(15, 30), UDim2.fromOffset(120, 14), 9);
Subtitle.TextColor3 = Color3.fromRGB(155, 135, 205);
Subtitle.TextXAlignment = Enum.TextXAlignment.Left;
local LibraryTab = makeButton(Main, "LIBRARY", UDim2.new(1, -240, 0, 9), UDim2.fromOffset(100, 30), Color3.fromRGB(110, 75, 165), 12);
local CustomTab = makeButton(Main, "CUSTOM", UDim2.new(1, -132, 0, 9), UDim2.fromOffset(90, 30), Color3.fromRGB(55, 45, 80), 12);
local Minimize = makeButton(Main, "−", UDim2.new(1, -36, 0, 9), UDim2.fromOffset(27, 30), Color3.fromRGB(55, 45, 80), 18);
local CommunityButton = makeButton(Main, "BUG? / SONG REQUEST", UDim2.fromOffset(190, 9), UDim2.fromOffset(124, 30), Color3.fromRGB(55, 45, 80), 9);
local Signature = makeLabel(Main, "Made by SYNTRØ ツ", UDim2.new(0, 0, 1, -18), UDim2.new(1, 0, 0, 14), 9);
Signature.TextColor3 = Color3.fromRGB(130, 120, 155);
local Content = Instance.new("Frame");
Content.Position = UDim2.fromOffset(0, 50);
Content.Size = UDim2.new(1, 0, 1, -70);
Content.BackgroundTransparency = 1;
Content.Parent = Main;
local CommunityOverlay = Instance.new("Frame");
CommunityOverlay.Size = UDim2.fromScale(1, 1);
CommunityOverlay.BackgroundColor3 = Color3.new(0, 0, 0);
CommunityOverlay.BackgroundTransparency = 1;
CommunityOverlay.Visible = false;
CommunityOverlay.ZIndex = 10;
CommunityOverlay.Parent = Gui;
local CommunityPanel = Instance.new("Frame");
CommunityPanel.AnchorPoint = Vector2.new(0.5, 0.5);
CommunityPanel.Position = UDim2.fromScale(0.5, 0.5);
CommunityPanel.Size = UDim2.fromOffset(0, 0);
CommunityPanel.BackgroundColor3 = Color3.fromRGB(25, 23, 38);
CommunityPanel.BorderSizePixel = 0;
CommunityPanel.ZIndex = 11;
CommunityPanel.Parent = CommunityOverlay;
makeCorner(CommunityPanel, 14);
local PanelStroke = Instance.new("UIStroke");
PanelStroke.Color = Color3.fromRGB(135, 90, 220);
PanelStroke.Thickness = 1.5;
PanelStroke.Parent = CommunityPanel;
local CommunityTitle = makeLabel(CommunityPanel, "SYNTRØ COMMUNITY", UDim2.fromOffset(15, 18), UDim2.new(1, -30, 0, 30), 18);
CommunityTitle.ZIndex = 12;
local CommunityInfo = makeLabel(CommunityPanel, "Found a bug or have a song request?\nJoin our Discord server!", UDim2.fromOffset(20, 62), UDim2.new(1, -40, 0, 55), 13);
CommunityInfo.ZIndex = 12;
local InviteLink = makeLabel(CommunityPanel, "discord.gg/6bUaZY6zVd", UDim2.fromOffset(15, 119), UDim2.new(1, -30, 0, 25), 12);
InviteLink.TextColor3 = Color3.fromRGB(180, 145, 255);
InviteLink.Visible = false;
InviteLink.ZIndex = 12;
local NoThanks = makeButton(CommunityPanel, "NO, THANKS", UDim2.fromOffset(20, 165), UDim2.fromOffset(145, 35), Color3.fromRGB(65, 55, 75), 11);
NoThanks.ZIndex = 12;
local Sure = makeButton(CommunityPanel, "SURE!", UDim2.fromOffset(195, 165), UDim2.fromOffset(145, 35), Color3.fromRGB(85, 65, 145), 11);
Sure.ZIndex = 12;
local CopyServerLink = makeButton(CommunityPanel, "COPY SERVER LINK", UDim2.fromOffset(195, 165), UDim2.fromOffset(145, 35), Color3.fromRGB(85, 65, 145), 10);
CopyServerLink.ZIndex = 12;
CopyServerLink.Visible = false;
local function closeCommunity()
	local FlatIdent_7873D = 0;
	while true do
		if (1 == FlatIdent_7873D) then
			task.wait(0.22);
			CommunityOverlay.Visible = false;
			break;
		end
		if (FlatIdent_7873D == 0) then
			tween(CommunityPanel, 0.2, {Size=UDim2.fromOffset(0, 0)}, Enum.EasingStyle.Back);
			tween(CommunityOverlay, 0.2, {BackgroundTransparency=1});
			FlatIdent_7873D = 1;
		end
	end
end
CommunityButton.Activated:Connect(function()
	local FlatIdent_92F66 = 0;
	while true do
		if (FlatIdent_92F66 == 2) then
			CopyServerLink.Visible = false;
			NoThanks.Text = "NO, THANKS";
			FlatIdent_92F66 = 3;
		end
		if (FlatIdent_92F66 == 1) then
			InviteLink.Visible = false;
			Sure.Visible = true;
			FlatIdent_92F66 = 2;
		end
		if (FlatIdent_92F66 == 0) then
			CommunityTitle.Text = "SYNTRØ COMMUNITY";
			CommunityInfo.Text = "Found a bug or have a song request?\nJoin our Discord server!";
			FlatIdent_92F66 = 1;
		end
		if (FlatIdent_92F66 == 4) then
			tween(CommunityOverlay, 0.2, {BackgroundTransparency=0.4});
			tween(CommunityPanel, 0.3, {Size=UDim2.fromOffset(360, 220)}, Enum.EasingStyle.Back);
			break;
		end
		if (FlatIdent_92F66 == 3) then
			CommunityOverlay.Visible = true;
			CommunityPanel.Size = UDim2.fromOffset(0, 0);
			FlatIdent_92F66 = 4;
		end
	end
end);
NoThanks.Activated:Connect(function()
	closeCommunity();
end);
Sure.Activated:Connect(function()
	CommunityTitle.Text = "THANK YOU!";
	CommunityInfo.Text = "Copy this invite link to join our community:";
	InviteLink.Visible = true;
	Sure.Visible = false;
	CopyServerLink.Visible = true;
	NoThanks.Text = "CLOSE";
	local YaySound = Instance.new("Sound");
	YaySound.SoundId = "rbxassetid://116847648586053";
	YaySound.Volume = 0.7;
	YaySound.Parent = Gui;
	YaySound:Play();
	YaySound.Ended:Connect(function()
		YaySound:Destroy();
	end);
end);
CopyServerLink.Activated:Connect(function()
	local FlatIdent_759F1 = 0;
	local invite;
	while true do
		if (0 == FlatIdent_759F1) then
			invite = "https://discord.gg/6bUaZY6zVd";
			if ((typeof(setclipboard) == "function") or (2903 == 1495)) then
				local ok = pcall(setclipboard, invite);
				if ok then
					CommunityInfo.Text = "Server link copied!";
				else
					local FlatIdent_512FF = 0;
					while true do
						if (FlatIdent_512FF == 0) then
							CommunityInfo.Text = "Copy isn't supported here. Link shown below:";
							InviteLink.Visible = true;
							break;
						end
					end
				end
			else
				local FlatIdent_829F9 = 0;
				while true do
					if (FlatIdent_829F9 == 0) then
						CommunityInfo.Text = "Copy isn't supported here. Link shown below:";
						InviteLink.Visible = true;
						break;
					end
				end
			end
			break;
		end
	end
end);
local LibraryView = Instance.new("Frame");
LibraryView.Size = UDim2.new(1, 0, 1, 0);
LibraryView.BackgroundTransparency = 1;
LibraryView.Parent = Content;
local SearchBox = Instance.new("TextBox");
SearchBox.Position = UDim2.fromOffset(14, 5);
SearchBox.Size = UDim2.new(1, -28, 0, 35);
SearchBox.BackgroundColor3 = Color3.fromRGB(31, 31, 44);
SearchBox.TextColor3 = Color3.fromRGB(245, 245, 255);
SearchBox.PlaceholderColor3 = Color3.fromRGB(145, 135, 160);
SearchBox.PlaceholderText = "Search songs...";
SearchBox.Text = "";
SearchBox.TextSize = 13;
SearchBox.Font = Enum.Font.Gotham;
SearchBox.ClearTextOnFocus = false;
SearchBox.BorderSizePixel = 0;
SearchBox.Parent = LibraryView;
makeCorner(SearchBox, 8);
local SongCount = makeLabel(LibraryView, "AVAILABLE SONGS", UDim2.fromOffset(15, 46), UDim2.new(1, -30, 0, 18), 9);
SongCount.TextXAlignment = Enum.TextXAlignment.Left;
SongCount.TextColor3 = Color3.fromRGB(155, 135, 205);
local SongList = Instance.new("ScrollingFrame");
SongList.Position = UDim2.fromOffset(14, 68);
SongList.Size = UDim2.new(1, -28, 1, -72);
SongList.BackgroundColor3 = Color3.fromRGB(27, 27, 39);
SongList.BorderSizePixel = 0;
SongList.ScrollBarThickness = 4;
SongList.ScrollBarImageColor3 = Color3.fromRGB(135, 90, 220);
SongList.CanvasSize = UDim2.new(0, 0, 0, 0);
SongList.Parent = LibraryView;
makeCorner(SongList, 8);
local ListLayout = Instance.new("UIListLayout");
ListLayout.Padding = UDim.new(0, 7);
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
ListLayout.Parent = SongList;
local ListPadding = Instance.new("UIPadding");
ListPadding.PaddingTop = UDim.new(0, 8);
ListPadding.PaddingLeft = UDim.new(0, 8);
ListPadding.PaddingRight = UDim.new(0, 8);
ListPadding.PaddingBottom = UDim.new(0, 8);
ListPadding.Parent = SongList;
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	SongList.CanvasSize = UDim2.new(0, 0, 0, obf_AND(ListLayout.AbsoluteContentSize.Y, 16) + obf_OR(ListLayout.AbsoluteContentSize.Y, 16));
end);
local CustomView = Instance.new("Frame");
CustomView.Size = UDim2.new(1, 0, 1, 0);
CustomView.BackgroundTransparency = 1;
CustomView.Visible = false;
CustomView.Parent = Content;
local SheetTitle = makeLabel(CustomView, "YOUR CUSTOM SHEET", UDim2.fromOffset(14, 5), UDim2.fromOffset(250, 18), 10);
SheetTitle.TextXAlignment = Enum.TextXAlignment.Left;
local SheetBox = Instance.new("TextBox");
SheetBox.Position = UDim2.fromOffset(14, 27);
SheetBox.Size = UDim2.fromOffset(270, 175);
SheetBox.BackgroundColor3 = Color3.fromRGB(31, 31, 44);
SheetBox.TextColor3 = Color3.fromRGB(245, 245, 255);
SheetBox.PlaceholderColor3 = Color3.fromRGB(130, 125, 150);
SheetBox.PlaceholderText = "Paste your sheet...";
SheetBox.Text = "";
SheetBox.TextSize = 12;
SheetBox.Font = Enum.Font.Code;
SheetBox.TextWrapped = true;
SheetBox.TextXAlignment = Enum.TextXAlignment.Left;
SheetBox.TextYAlignment = Enum.TextYAlignment.Top;
SheetBox.MultiLine = true;
SheetBox.ClearTextOnFocus = false;
SheetBox.BorderSizePixel = 0;
SheetBox.Parent = CustomView;
makeCorner(SheetBox, 8);
local Controls = Instance.new("Frame");
Controls.Position = UDim2.fromOffset(300, 5);
Controls.Size = UDim2.new(1, -314, 1, -10);
Controls.BackgroundTransparency = 1;
Controls.Parent = CustomView;
local BPMTitle = makeLabel(Controls, "BPM", UDim2.fromOffset(0, 3), UDim2.fromOffset(55, 27), 13);
BPMTitle.TextXAlignment = Enum.TextXAlignment.Left;
local BPMLabel = makeLabel(Controls, "120", UDim2.fromOffset(65, 3), UDim2.fromOffset(55, 27), 15);
local Minus = makeButton(Controls, "−", UDim2.fromOffset(130, 2), UDim2.fromOffset(35, 29), Color3.fromRGB(50, 48, 70), 16);
local Plus = makeButton(Controls, "+", UDim2.fromOffset(173, 2), UDim2.fromOffset(35, 29), Color3.fromRGB(50, 48, 70), 16);
Minus.Activated:Connect(function()
	local FlatIdent_89562 = 0;
	while true do
		if (FlatIdent_89562 == 0) then
			BPM = math.max(30, BPM - 5);
			BPMLabel.Text = tostring(BPM);
			break;
		end
	end
end);
Plus.Activated:Connect(function()
	BPM = math.min(300, obf_AND(BPM, 5) + obf_OR(BPM, 5));
	BPMLabel.Text = tostring(BPM);
end);
local LoopButton = makeButton(Controls, "LOOP  OFF", UDim2.fromOffset(0, 42), UDim2.new(1, 0, 0, 30), Color3.fromRGB(48, 45, 68), 12);
LoopButton.Activated:Connect(function()
	local FlatIdent_10DED = 0;
	while true do
		if (FlatIdent_10DED == 1) then
			tween(LoopButton, 0.2, {BackgroundColor3=((Loop and Color3.fromRGB(80, 55, 130)) or Color3.fromRGB(48, 45, 68))});
			break;
		end
		if (FlatIdent_10DED == 0) then
			Loop = not Loop;
			LoopButton.Text = (Loop and "LOOP  ON") or "LOOP  OFF";
			FlatIdent_10DED = 1;
		end
	end
end);
local Play = makeButton(Controls, "▶  PLAY", UDim2.fromOffset(0, 84), UDim2.new(0.5, -5, 0, 34), Color3.fromRGB(45, 115, 80), 12);
local Pause = makeButton(Controls, "Ⅱ  PAUSE", UDim2.new(0.5, 5, 0, 84), UDim2.new(0.5, -5, 0, 34), Color3.fromRGB(65, 75, 135), 12);
local Stop = makeButton(Controls, "■  STOP", UDim2.fromOffset(0, 128), UDim2.new(1, 0, 0, 30), Color3.fromRGB(125, 55, 65), 12);
Stop.Name = "StopButton";
local Status = makeLabel(Controls, "● READY", UDim2.fromOffset(0, 165), UDim2.new(1, 0, 0, 20), 10);
Status.TextColor3 = Color3.fromRGB(130, 205, 155);
Status.TextXAlignment = Enum.TextXAlignment.Left;
local ActiveColor = Color3.fromRGB(90, 170, 255);
local InactiveColor = Color3.fromRGB(45, 45, 55);
local function setTab(tab, fromLibrary)
	if ((4546 >= 2275) and (minimized or (1180 == 2180))) then
		return;
	end
	LibraryView.Visible = false;
	CustomView.Visible = false;
	if ((819 >= 22) and (tab == "LIBRARY")) then
		local FlatIdent_7147 = 0;
		while true do
			if (FlatIdent_7147 == 0) then
				CurrentTab = "LIBRARY";
				LibraryView.Visible = true;
				FlatIdent_7147 = 1;
			end
			if (FlatIdent_7147 == 1) then
				SheetBox.Visible = true;
				SheetTitle.Visible = true;
				break;
			end
		end
	elseif ((3162 == 3162) and (4090 < 4653) and (tab == "CUSTOM")) then
		local FlatIdent_6D884 = 0;
		while true do
			if (0 == FlatIdent_6D884) then
				CurrentTab = "CUSTOM";
				CustomView.Visible = true;
				FlatIdent_6D884 = 1;
			end
			if (FlatIdent_6D884 == 1) then
				SheetBox.Visible = not fromLibrary;
				SheetTitle.Visible = not fromLibrary;
				break;
			end
		end
	else
		return;
	end
	LibraryTab.BackgroundColor3 = ((CurrentTab == "LIBRARY") and ActiveColor) or InactiveColor;
	CustomTab.BackgroundColor3 = ((CurrentTab == "CUSTOM") and ActiveColor) or InactiveColor;
end
LibraryTab.Activated:Connect(function()
	local FlatIdent_33DE6 = 0;
	while true do
		if (0 == FlatIdent_33DE6) then
			if (minimized or (2652 < 196)) then
				return;
			end
			setTab("LIBRARY");
			FlatIdent_33DE6 = 1;
		end
		if (FlatIdent_33DE6 == 1) then
			Status.Text = "● LIBRARY MODE";
			break;
		end
	end
end);
CustomTab.Activated:Connect(function()
	local FlatIdent_1512 = 0;
	while true do
		if (FlatIdent_1512 == 1) then
			setTab("CUSTOM", false);
			Status.Text = "● CUSTOM MODE";
			break;
		end
		if (0 == FlatIdent_1512) then
			if (minimized or (2369 > 4429)) then
				return;
			end
			if ((4095 >= 3183) and (4135 < 4817) and LoadedFromLibrary) then
				local FlatIdent_1DFAF = 0;
				while true do
					if (FlatIdent_1DFAF == 0) then
						SheetBox.Text = "";
						Sheet = "";
						FlatIdent_1DFAF = 1;
					end
					if (FlatIdent_1DFAF == 1) then
						LoadedFromLibrary = false;
						break;
					end
				end
			end
			FlatIdent_1512 = 1;
		end
	end
end);
local function clearSongButtons()
	for _, child in ipairs(SongList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy();
		end
	end
end
local function loadSong(song)
	local FlatIdent_1E4CB = 0;
	while true do
		if (FlatIdent_1E4CB == 0) then
			if Playing then
				return;
			end
			Sheet = song.sheet;
			FlatIdent_1E4CB = 1;
		end
		if (FlatIdent_1E4CB == 1) then
			BPM = song.bpm;
			BPMLabel.Text = tostring(BPM);
			FlatIdent_1E4CB = 2;
		end
		if (FlatIdent_1E4CB == 4) then
			Status.TextColor3 = Color3.fromRGB(130, 205, 155);
			break;
		end
		if (FlatIdent_1E4CB == 2) then
			LoadedFromLibrary = true;
			SheetBox.Text = "";
			FlatIdent_1E4CB = 3;
		end
		if (3 == FlatIdent_1E4CB) then
			setTab("CUSTOM", true);
			Status.Text = "● LOADED: " .. song.title;
			FlatIdent_1E4CB = 4;
		end
	end
end
local function refreshLibrary()
	clearSongButtons();
	local query = SearchBox.Text:lower();
	local shown = 0;
	for _, song in ipairs(LibrarySongs) do
		if song.title:lower():find(query, 1, true) then
			local FlatIdent_35A31 = 0;
			local SongButton;
			local SongName;
			local SongBPM;
			local LoadIcon;
			while true do
				if (5 == FlatIdent_35A31) then
					SongName.TextTruncate = Enum.TextTruncate.AtEnd;
					SongName.Parent = SongButton;
					SongBPM = Instance.new("TextLabel");
					SongBPM.BackgroundTransparency = 1;
					FlatIdent_35A31 = 6;
				end
				if (FlatIdent_35A31 == 10) then
					LoadIcon.Parent = SongButton;
					SongButton.Activated:Connect(function()
						loadSong(song);
					end);
					SongButton.MouseEnter:Connect(function()
						tween(SongButton, 0.12, {BackgroundColor3=Color3.fromRGB(75, 58, 110)});
					end);
					SongButton.MouseLeave:Connect(function()
						tween(SongButton, 0.12, {BackgroundColor3=Color3.fromRGB(48, 42, 68)});
					end);
					break;
				end
				if (FlatIdent_35A31 == 0) then
					shown += 1
					SongButton = Instance.new("TextButton");
					SongButton.Name = "SongButton";
					SongButton.Size = UDim2.new(1, 0, 0, 48);
					FlatIdent_35A31 = 1;
				end
				if (FlatIdent_35A31 == 3) then
					SongName.BackgroundTransparency = 1;
					SongName.Position = UDim2.fromOffset(12, 4);
					SongName.Size = UDim2.new(1, -70, 0, 22);
					SongName.Text = song.title;
					FlatIdent_35A31 = 4;
				end
				if (FlatIdent_35A31 == 2) then
					SongButton.LayoutOrder = shown;
					SongButton.Parent = SongList;
					makeCorner(SongButton, 7);
					SongName = Instance.new("TextLabel");
					FlatIdent_35A31 = 3;
				end
				if (FlatIdent_35A31 == 7) then
					SongBPM.TextSize = 10;
					SongBPM.Font = Enum.Font.Gotham;
					SongBPM.TextXAlignment = Enum.TextXAlignment.Left;
					SongBPM.Parent = SongButton;
					FlatIdent_35A31 = 8;
				end
				if (FlatIdent_35A31 == 1) then
					SongButton.BackgroundColor3 = Color3.fromRGB(48, 42, 68);
					SongButton.Text = "";
					SongButton.BorderSizePixel = 0;
					SongButton.AutoButtonColor = false;
					FlatIdent_35A31 = 2;
				end
				if (FlatIdent_35A31 == 4) then
					SongName.TextColor3 = Color3.fromRGB(245, 240, 255);
					SongName.TextSize = 13;
					SongName.Font = Enum.Font.GothamBold;
					SongName.TextXAlignment = Enum.TextXAlignment.Left;
					FlatIdent_35A31 = 5;
				end
				if (FlatIdent_35A31 == 8) then
					LoadIcon = Instance.new("TextLabel");
					LoadIcon.BackgroundTransparency = 1;
					LoadIcon.Position = UDim2.new(1, -45, 0, 0);
					LoadIcon.Size = UDim2.fromOffset(35, 48);
					FlatIdent_35A31 = 9;
				end
				if (6 == FlatIdent_35A31) then
					SongBPM.Position = UDim2.fromOffset(12, 25);
					SongBPM.Size = UDim2.new(1, -70, 0, 16);
					SongBPM.Text = tostring(song.bpm) .. " BPM";
					SongBPM.TextColor3 = Color3.fromRGB(165, 145, 205);
					FlatIdent_35A31 = 7;
				end
				if (9 == FlatIdent_35A31) then
					LoadIcon.Text = "▶";
					LoadIcon.TextColor3 = Color3.fromRGB(190, 160, 255);
					LoadIcon.TextSize = 17;
					LoadIcon.Font = Enum.Font.GothamBold;
					FlatIdent_35A31 = 10;
				end
			end
		end
	end
	SongCount.Text = ((shown == 0) and "NO SONGS FOUND") or (tostring(shown) .. " SONG(S) AVAILABLE");
end
SearchBox:GetPropertyChangedSignal("Text"):Connect(refreshLibrary);
Play.Activated:Connect(function()
	if (not LoadedFromLibrary or (3711 < 1008)) then
		Sheet = SheetBox.Text;
	end
	if not Playing then
		local FlatIdent_5CA49 = 0;
		local success;
		while true do
			if (FlatIdent_5CA49 == 0) then
				success = playSheet();
				if ((272 == 272) and success) then
					local FlatIdent_6C34 = 0;
					while true do
						if (0 == FlatIdent_6C34) then
							Status.Text = "● PLAYING";
							Status.TextColor3 = Color3.fromRGB(120, 220, 155);
							break;
						end
					end
				else
					Status.Text = "● EMPTY SHEET";
				end
				break;
			end
		end
	end
end);
Pause.Activated:Connect(function()
	local FlatIdent_98388 = 0;
	while true do
		if (FlatIdent_98388 == 2) then
			tween(Pause, 0.15, {BackgroundColor3=((Paused and Color3.fromRGB(105, 85, 175)) or Color3.fromRGB(65, 75, 135))});
			break;
		end
		if (FlatIdent_98388 == 0) then
			if not Playing then
				local FlatIdent_1691A = 0;
				while true do
					if (FlatIdent_1691A == 0) then
						Status.Text = "● NOTHING PLAYING";
						return;
					end
				end
			end
			Paused = not Paused;
			FlatIdent_98388 = 1;
		end
		if (FlatIdent_98388 == 1) then
			Pause.Text = (Paused and "▶ RESUME") or "Ⅱ  PAUSE";
			Status.Text = (Paused and "● PAUSED") or "● PLAYING";
			FlatIdent_98388 = 2;
		end
	end
end);
Stop.Activated:Connect(function()
	StopRequested = true;
	Paused = false;
	releaseAll();
	Status.Text = "● STOPPED";
	Status.TextColor3 = Color3.fromRGB(220, 120, 120);
	Pause.Text = "Ⅱ  PAUSE";
	tween(Stop, 0.15, {BackgroundColor3=Color3.fromRGB(125, 55, 65)});
end);
Minimize.Activated:Connect(function()
	local FlatIdent_466B2 = 0;
	while true do
		if (FlatIdent_466B2 == 0) then
			minimized = not minimized;
			if (((100 <= 3123) and minimized) or (1049 <= 906)) then
				Content.Visible = false;
				Signature.Visible = false;
				LibraryTab.Active = false;
				CustomTab.Active = false;
				tween(Main, 0.22, {Size=UDim2.fromOffset(560, 48)});
				Minimize.Text = "+";
			else
				local FlatIdent_1A54 = 0;
				while true do
					if (FlatIdent_1A54 == 2) then
						CustomTab.Active = true;
						Minimize.Text = "−";
						break;
					end
					if (FlatIdent_1A54 == 1) then
						Signature.Visible = true;
						LibraryTab.Active = true;
						FlatIdent_1A54 = 2;
					end
					if (0 == FlatIdent_1A54) then
						tween(Main, 0.22, {Size=UDim2.fromOffset(560, 330)});
						Content.Visible = true;
						FlatIdent_1A54 = 1;
					end
				end
			end
			break;
		end
	end
end);
local dragging = false;
local dragStart;
local startPosition;
Header.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.Touch) or (input.UserInputType == Enum.UserInputType.MouseButton1) or (1369 > 4987)) then
		dragging = true;
		dragStart = input.Position;
		startPosition = Main.Position;
	end
end);
UIS.InputChanged:Connect(function(input)
	if ((4513 > 2726) and ((dragging and ((input.UserInputType == Enum.UserInputType.Touch) or (input.UserInputType == Enum.UserInputType.MouseMovement))) or (863 >= 4584))) then
		local FlatIdent_22A5C = 0;
		local delta;
		while true do
			if (0 == FlatIdent_22A5C) then
				delta = input.Position - dragStart;
				Main.Position = UDim2.new(startPosition.X.Scale, obf_AND(startPosition.X.Offset, delta.X) + obf_OR(startPosition.X.Offset, delta.X), startPosition.Y.Scale, obf_AND(startPosition.Y.Offset, delta.Y) + obf_OR(startPosition.Y.Offset, delta.Y));
				break;
			end
		end
	end
end);
UIS.InputEnded:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.Touch) or (input.UserInputType == Enum.UserInputType.MouseButton1) or (1481 >= 2658)) then
		dragging = false;
	end
end);
Main.Size = UDim2.fromOffset(560, 0);
tween(Main, 0.35, {Size=UDim2.fromOffset(560, 330)}, Enum.EasingStyle.Back);
setTab("LIBRARY");
refreshLibrary();
task.spawn(function()
	for attempt = 1, 5 do
		local success = pcall(function()
			StarterGui:SetCore("SendNotification", {Title="SYNTRØ AUTO PIANO",Text="Auto Piano + Library loaded!",Duration=5});
		end);
		if (success or (724 >= 1668)) then
			break;
		end
		task.wait(1);
	end
end);
