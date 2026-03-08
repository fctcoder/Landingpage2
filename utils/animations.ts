import anime from 'animejs'

export const animationPresets = {
  fadeIn: {
    opacity: [0, 1],
    duration: 600,
    easing: 'easeOutQuad'
  },
  fadeInUp: {
    opacity: [0, 1],
    translateY: [30, 0],
    duration: 800,
    easing: 'easeOutExpo'
  },
  fadeInDown: {
    opacity: [0, 1],
    translateY: [-30, 0],
    duration: 800,
    easing: 'easeOutExpo'
  },
  slideInLeft: {
    opacity: [0, 1],
    translateX: [-50, 0],
    duration: 800,
    easing: 'easeOutExpo'
  },
  slideInRight: {
    opacity: [0, 1],
    translateX: [50, 0],
    duration: 800,
    easing: 'easeOutExpo'
  },
  scaleIn: {
    opacity: [0, 1],
    scale: [0.8, 1],
    duration: 600,
    easing: 'easeOutBack'
  },
  bounceIn: {
    opacity: [0, 1],
    scale: [0.3, 1.05, 1],
    duration: 800,
    easing: 'easeOutElastic(1, 0.5)'
  },
  rotateIn: {
    opacity: [0, 1],
    rotate: [-15, 0],
    scale: [0.9, 1],
    duration: 600,
    easing: 'easeOutQuad'
  },
  slideUp: {
    translateY: [100, 0],
    opacity: [0, 1],
    duration: 1000,
    easing: 'easeOutExpo'
  },
  slideDown: {
    translateY: [-100, 0],
    opacity: [0, 1],
    duration: 1000,
    easing: 'easeOutExpo'
  }
}

export const scrollAnimations = {
  reveal: (selector: string, options?: anime.AnimeParams) => {
    if (typeof window === 'undefined') return
    
    const elements = document.querySelectorAll(selector)
    
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            anime({
              targets: entry.target,
              opacity: [0, 1],
              translateY: [50, 0],
              duration: 800,
              easing: 'easeOutExpo',
              ...options
            })
            observer.unobserve(entry.target)
          }
        })
      },
      { threshold: 0.1 }
    )
    
    elements.forEach((el) => observer.observe(el))
  },
  
  staggerReveal: (selector: string, staggerDelay: number = 100) => {
    if (typeof window === 'undefined') return
    
    const elements = document.querySelectorAll(selector)
    
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            anime({
              targets: selector,
              opacity: [0, 1],
              translateY: [30, 0],
              delay: anime.stagger(staggerDelay),
              duration: 800,
              easing: 'easeOutExpo'
            })
            observer.disconnect()
          }
        })
      },
      { threshold: 0.1 }
    )
    
    if (elements.length > 0) {
      observer.observe(elements[0])
    }
  }
}

export const pageTransitions = {
  enter: (el: Element, done: () => void) => {
    anime({
      targets: el,
      opacity: [0, 1],
      translateY: [20, 0],
      duration: 400,
      easing: 'easeOutQuad',
      complete: done
    })
  },
  
  leave: (el: Element, done: () => void) => {
    anime({
      targets: el,
      opacity: [1, 0],
      translateY: [0, -20],
      duration: 300,
      easing: 'easeInQuad',
      complete: done
    })
  }
}

export const buttonAnimations = {
  pulse: (element: HTMLElement) => {
    anime({
      targets: element,
      scale: [1, 1.05, 1],
      duration: 600,
      easing: 'easeInOutQuad'
    })
  },
  
  ripple: (event: MouseEvent, element: HTMLElement) => {
    const rect = element.getBoundingClientRect()
    const ripple = document.createElement('span')
    ripple.className = 'absolute bg-white/30 rounded-full pointer-events-none'
    
    const size = Math.max(rect.width, rect.height)
    ripple.style.width = ripple.style.height = `${size}px`
    ripple.style.left = `${event.clientX - rect.left - size / 2}px`
    ripple.style.top = `${event.clientY - rect.top - size / 2}px`
    
    element.appendChild(ripple)
    
    anime({
      targets: ripple,
      scale: [0, 2],
      opacity: [1, 0],
      duration: 600,
      easing: 'easeOutExpo',
      complete: () => ripple.remove()
    })
  }
}

export const carouselAnimations = {
  slide: (currentSlide: number, direction: 'next' | 'prev') => {
    return {
      translateX: direction === 'next' ? ['100%', '0%'] : ['-100%', '0%'],
      opacity: [0, 1],
      duration: 500,
      easing: 'easeOutExpo'
    }
  },
  
  fade: {
    opacity: [0, 1],
    duration: 400,
    easing: 'easeOutQuad'
  }
}

export const modalAnimations = {
  open: {
    scale: [0.9, 1],
    opacity: [0, 1],
    duration: 300,
    easing: 'easeOutBack'
  },
  
  close: {
    scale: [1, 0.9],
    opacity: [1, 0],
    duration: 200,
    easing: 'easeInQuad'
  },
  
  backdropOpen: {
    opacity: [0, 1],
    duration: 200,
    easing: 'easeOutQuad'
  },
  
  backdropClose: {
    opacity: [1, 0],
    duration: 150,
    easing: 'easeInQuad'
  }
}

export const counterAnimation = (
  target: string | HTMLElement,
  endValue: number,
  duration: number = 2000,
  startValue: number = 0
) => {
  return anime({
    targets: target,
    innerHTML: [startValue, endValue],
    round: 1,
    duration,
    easing: 'easeOutExpo'
  })
}

export const typewriterEffect = (
  element: HTMLElement,
  text: string,
  duration: number = 50
) => {
  element.textContent = ''
  const chars = text.split('')
  
  chars.forEach((char, index) => {
    setTimeout(() => {
      element.textContent += char
    }, index * duration)
  })
}
