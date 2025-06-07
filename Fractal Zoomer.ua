# Experimental!
Iris ~ "git: github.com/Marcos-cat/iris"

Lazy            ← 1
BackgroundColor ← °hsv ⚂_⚂_1
ResWidth        ← 1024
ResHeight       ← 1024
WinScale        ← 1

BurningShipify ← 1

ThreadChunks ← 16

⍤"Width must be divisible by num of chunks four times"=0◿ ThreadChunks ÷₄ ResWidth
⍤"Height must be divisible by num of chunks four times"=0◿ ThreadChunks ÷₄ ResHeight

DefaultZ        ← 0
DefaultPosition ← ¯0.5r0i
DefaultScale    ← ¯1 # logarithmic

Iris~Open × WinScale ResWidth_ResHeight "Fractal Zoomer"

┌─╴Fractal
  ~ {Color Position Z Zoom Width Height HighRes}

  # RenderedChunk ? CWindow
  RenderChunk ← (
    100 ≡₀(°⊟₃°□)
    ⨬(⟜⍥(⊃(+⊙(<2⌵)|⊸+°√⋅⊙∘))         # BURNING SHIP
    | ⟜⍥(⊃(+⊙(<2⌵)|⊸+°√ ⍜°ℂ(∩⌵)⋅⊙∘)) # MANDELBROT
    ) BurningShipify
    ×⊸≤1⌵ ⊙⋅◌ ⁿ1/2÷
  )

  # Image ? Fractal
  RenderFractal ↚ |1 ×¤¤ ⊃Color(
    +˜÷ ⊞ℂ×˜÷⟜⤙∩(-⊸¬ ÷⟜⇡) ⊃(Height|Width|˜ⁿ2Zoom|Position|∘)
    +1.˜↯ ⊃(⋅⋅Z|⊙∘) ⊸△
    ≡₀(□⊟₃) # THREADIFICATION!!
    ⍜⧈∘(
      wait≡₂pool(
        RenderChunk
      )
    ) ¤˙⊟¯ThreadChunks
  )

  RenderLowRes ↚ (
    ⍜Width÷₄ ⍜Height÷₄
    ▽₂ 4 RenderFractal
  )

  Render ← ⨬(RenderLowRes|RenderFractal)⊸HighRes
└─╴

┌─╴RenderState
  ~ {IsMoving ForceLazy TextureObj FractalObj CurrentRender}

  # RenderState ? RenderState
  UpdateFromMouse ← Iris~Mouse!Fractal!(
    ⍜(FractalObj
    | ⍥(°⊸Position -×2÷WinScale÷ResHeight˜÷ ⍜°ℂ¯ ÷i Change⊸⊃(˜ⁿ2Zoom|Position)) Down Left # Panning
      ⍥(⍜(Z|+ ÷ResHeight Change)) Down Right                                              # Julia Shifting
      ⍥(⍜(Z|⍜°ℂ(∩×₀))) Iris~Key~Pressed @r
      ⍜(Zoom|+ ÷5 Scroll) # Scaling
    )
    ⍜(ForceLazy|⨬(∘|¬) Iris~Key~Pressed @t)
    °⊸IsMoving >0+⊃(ForceLazy|×Lazy + ⌵Scroll +∩Down Right Left).
    ⍜⊙FractalObj(°⊸Fractal~HighRes¬) ⊸IsMoving

    ¬≍⊸⊃FractalObj CurrentRender
    ⍥(
      ⊃(Fractal~Render|°⊸CurrentRender)⊸FractalObj
      ⍜⊙TextureObj °⊸Iris~Texture~Image
    )
  )

  # ? RenderState
  Render ← Iris~Texture~DrawScaled⊃(TextureObj|WinScale 0_0)
└─╴

RenderState~New (
  . Fractal~New BackgroundColor DefaultPosition DefaultZ DefaultScale ResWidth ResHeight 1 # Fractal
  Iris~Texture~LoadImage ⊸Fractal~Render                                                   # Texture & CurrentTexture
  0 0                                                                                      # IsMoving & Force Lazy
)

◌Iris~Loop!(
  ⊸RenderState~Render RenderState~UpdateFromMouse
  Draw~Text [ln Screen~FPS 1 1] 20 10_10 Screen~FPS
  Draw~Text White 20 10_30 ˜$"Pos = _ + _i" °ℂ ⊸(Fractal~Position RenderState~CurrentRender)
  Draw~Text White 20 10_50 $"Z = _ + _i [R to Reset]" °ℂ ⊸(Fractal~Z RenderState~CurrentRender)
  Draw~Text White 20 10_70 °⋕ ˜ⁿ2 ⊸(Fractal~Zoom RenderState~CurrentRender)
  Draw~Text White 20 10_90 $"Force Lazy is _ [T to Toggle]" ⨬("FALSE"|"TRUE") ⊸(RenderState~ForceLazy)
)
