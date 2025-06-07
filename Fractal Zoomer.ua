# Experimental!
Iris ~ "git: github.com/Marcos-cat/iris"

Lazy            ← 1
BackgroundColor ← (⚂_⚂_⚂)
ResWidth        ← 512
ResHeight       ← 512
WinScale        ← 3

ThreadChunks ← 16

⍤"Width must be divisible by num of chunks four times"=0◿ ThreadChunks ÷₄ ResWidth
⍤"Height must be divisible by num of chunks four times"=0◿ ThreadChunks ÷₄ ResHeight

DefaultPosition ← ¯0.5r0i
DefaultScale    ← ¯1 # logarithmic

Iris~Open × WinScale ResWidth_ResHeight "Fractal Zoomer"

┌─╴Fractal
  ~ {Color Position Zoom Height Width}

  # RenderedChunk ? BaseChunk
  RenderChunk ↚ memo(
    +1.˜↯ 0 ⊸△
    ⁿ1/2÷⟜⍥(⊃(+⊙(<2⌵)|⊸+°√⋅⊙∘))500
    ×⊸≤1⌵⊙⋅◌
  )

  # Image ? Fractal
  RenderFractal ← |1 ×¤¤ ⊃Color(
    +˜÷ ⊞ℂ×˜÷⟜⤙∩(-⊸¬ ÷⟜⇡) ⊃(Height|Width|˜ⁿ2Zoom|Position)
    ⍜⧈∘(
      wait≡₂pool(
        RenderChunk
      )
    ) ¤˙⊟¯ThreadChunks
  )

  # Image ? Fractal
  RenderLowRes ← (
    ⍜Width÷₂ ⍜Height÷₂
    ▽₂ 2 RenderFractal
  )
└─╴

┌─╴RenderState
  ~ {IsMoving TextureObj FractalObj}
  # RenderState ? RenderState
  UpdateFromMouse ← Iris~Mouse!Fractal!(
    ⍜(FractalObj
    | ⍥(°⊸Position -×2÷WinScale÷ResHeight˜÷ ⍜°ℂ¯ ÷i Change⊸⊃(˜ⁿ2Zoom|Position)) Down Left # Panning
      ⍜(Zoom|+ ÷10 Scroll)                                                                # Scaling
    )
    °⊸IsMoving >0+ ⌵Scroll Down Left
  )

  # ? IsMoving Fractal Texture
  Render ← Iris~Texture!(
    °⊸Image⨬(Fractal~RenderFractal|Fractal~RenderLowRes)
    DrawScaled⊃(∘|WinScale 0_0)
  )
└─╴

RenderState~New (
  Fractal~New BackgroundColor DefaultPosition DefaultScale ResWidth ResHeight # Fractal
  Iris~Texture~LoadImage↯ ResWidth_ResHeight_3 0                              # Texture
  1                                                                           # IsMoving
)

Iris~Loop!(
  RenderState!(
    UpdateFromMouse
    Render⊃(IsMoving|FractalObj|TextureObj|∘)
  )
)
