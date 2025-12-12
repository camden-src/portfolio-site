# Portfolio Site - Audio Visual Experience

*Last updated: 2024-12-12*

## Project Purpose

This is NOT a traditional portfolio documenting past work. This is an **immersive audio-visual experience** that serves as both artwork and professional presence. The site itself is the creative output, not documentation of separate creative outputs.

## Creative Context

**Artist identity:** Multidisciplinary artist (music, visual, code)

**Current production focus:** Music composition and production using instruments and electronic hardware

**Visual component:** Digital interpretation and generation - code-driven, algorithmic, responsive to audio. Historical visual work in traditional media exists as background but is not currently in active production.

**Technical background:** 13+ years DevOps/Infrastructure engineering informs the creative practice - treating code as medium, systems thinking applied to art

## Site Vision

### Core Experience
- Music track plays (original production)
- WebGL visuals respond in real-time to audio features (frequency, amplitude, rhythm, spectral content)
- Shader-driven generative visuals - not illustrations of music, but another instrument in the composition
- Immersive, fullscreen experience prioritizing the work itself over interface chrome

### Supporting Content
- **Bio:** Minimal, direct explanation of who and what (context-generated to avoid agonizing over it)
- **Artist statement:** Present as decorum requires, but written in honest, no-frills voice
- **Track information:** Basic credits and technical notes when relevant
- **Contact information:** How to reach for opportunities

### Voice and Tone
- **NOT:** Aspirational art-world language, "pushing boundaries," "exploring the intersection of," marketing word soup
- **YES:** Direct statements about what the work is and why it exists, honest about process and influences, matter-of-fact technical details
- **Approach:** The work should speak for itself; text exists to provide context, not to sell or inflate

## Technical Architecture

### Structure
```
index.html              # Main audio-visual experience (fullscreen canvas)
about.html              # Minimal supporting text (bio, statement, contact)
/js/
  main.js               # Audio-visual orchestration
  audio-analyzer.js     # Web Audio API feature extraction
  visuals.js            # WebGL/Three.js management
  ui.js                 # Minimal playback controls
/shaders/
  vertex.glsl           # Vertex shader(s)
  fragment-*.glsl       # Fragment shaders (potentially multiple visual modes)
/tracks/
  track-01.mp3          # Original music productions
  track-02.mp3
  [...]
/css/
  minimal.css           # UI chrome styling only
```

### Technical Approach
- **No framework bloat:** Vanilla JavaScript with ES6 modules, modern browser features
- **Three.js as WebGL wrapper:** Simplifies WebGL complexity while learning GLSL shaders
- **Web Audio API:** Native audio analysis via AnalyserNode, FFT data extraction
- **GLSL shaders:** Core visual generation, direct shader programming for creative control
- **Static site:** HTML/JS/audio files, no build system initially (add bundler only if optimization needed)
- **Deployment:** Linode Object Storage (ethical infrastructure choice, avoiding major cloud providers with military contracts)

## Content Generation from Contexts

### Bio (target: 100 words)
**Source contexts:** 
- `career/employment_history.md` (technical background)
- `creative/music-production.md` (current practice)
- `career/technical_experience.md` (skills informing creative work)

**Prompt guidance:**
- First person, direct voice
- Bridge technical expertise with creative practice
- Explain what the work is without inflating it
- Mention seeking mission-driven work opportunities

### Artist Statement (target: 150 words)
**Source contexts:**
- `creative/music-production.md`
- `creative/visual-art.md` (when developed)
- Technical philosophy from career contexts

**Prompt guidance:**
- Honest about influences and approach
- Clear about what is made and why
- Avoid art-world clichés and buzzwords
- OK to mention technical process - it's part of the practice
- Direct statements, no vague aspirational language

### Track Descriptions (target: 50 words each)
**Source contexts:**
- Track-specific production notes (to be created per track)
- Technical tools and processes used

**Prompt guidance:**
- Medium, duration, production approach
- Technical details when relevant (DAW, hardware, synthesis approach)
- Brief description of visual system response
- No over-explaining or defensive framing

## Design Principles

### Visual Hierarchy
1. **Primary:** Audio-visual experience (fullscreen, immersive)
2. **Secondary:** Playback controls (minimal, non-intrusive)
3. **Tertiary:** Supporting text (available but not in the way)

### User Experience
- **Landing:** Immediate visual presence, clear play/pause control
- **Interaction:** Minimal clicks to experience, optional deeper information
- **Navigation:** Simple escape to bio/info, easy return to experience
- **Accessibility:** Consider audio descriptions for visuals, keyboard controls

### Technical Constraints
- **Load time:** Optimize audio file sizes, progressive loading if needed
- **Performance:** Maintain 60fps for visuals, efficient shader code
- **Browser support:** Modern browsers only (WebGL 2.0, Web Audio API, ES6 modules)
- **Mobile:** Consider mobile experience but prioritize desktop immersive viewing

## What This Site Is NOT

- NOT a blog or regular publishing platform
- NOT a traditional portfolio with project case studies
- NOT documentation of external work
- NOT a commercial/client work showcase
- NOT trying to appear more established than reality
- NOT using frameworks for the sake of frameworks (React, Vue, Hugo)

## What This Site IS

- An artwork that is also a professional presence
- Demonstration of technical and creative capabilities simultaneously
- Honest presentation of current creative output
- Platform for audio-visual experimentation
- Evidence of systems thinking applied to art
- A statement about code as creative medium

## Deployment and Maintenance

**Hosting:** Linode Object Storage (ethical choice, static hosting)

**Version control:** Git repository, likely public to demonstrate technical approach

**Updates:** 
- Add tracks as produced
- Iterate shader approaches as skills develop
- Minimal text updates (bio changes, new opportunities)
- Not a frequent publishing workflow

**No CMS needed:** Direct file editing, deploy via rsync or GitHub Actions

## Related Contexts

- `career/technical_experience.md` - Technical skills informing creative practice
- `career/employment_history.md` - Professional background and current job search
- `creative/music-production.md` - Current creative focus and production approach
- `creative/visual-art.md` - Background in visual work, future development
- `noise2signal-llc/overview.md` - Business entity if relevant to professional opportunities

## When This Context Applies

This context is relevant for conversations about:
- Portfolio site development and technical decisions
- Content generation for bio, artist statement, or track descriptions
- Balancing professional and creative presentation
- Web technology choices for audio-visual work
- Voice and tone for artist communications
- Integration of technical background with creative practice
