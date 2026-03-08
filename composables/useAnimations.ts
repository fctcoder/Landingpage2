import anime from 'animejs'

export type AnimationPreset = 
  | 'fadeIn' 
  | 'fadeInUp' 
  | 'fadeInDown' 
  | 'slideInLeft' 
  | 'slideInRight' 
  | 'scaleIn' 
  | 'rotateIn'

export interface AnimationOptions {
  duration?: number
  delay?: number
  easing?: string
  stagger?: number
}

export const useAnimations = () => {
  const animate = (
    targets: string | HTMLElement | HTMLElement[],
    properties: anime.AnimeParams,
    options?: AnimationOptions
  ) => {
    return anime({
      targets,
      ...properties,
      duration: options?.duration ?? 800,
      delay: options?.delay ?? 0,
      easing: options?.easing ?? 'easeOutExpo'
    })
  }

  const animateOnScroll = (
    selector: string,
    animation: AnimationPreset,
    options?: AnimationOptions
  ) => {
    if (process.client) {
      const observer = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              const element = entry.target as HTMLElement
              element.classList.add('animate-visible')
              
              switch (animation) {
                case 'fadeIn':
                  animate(element, {
                    opacity: [0, 1]
                  }, options)
                  break
                case 'fadeInUp':
                  animate(element, {
                    opacity: [0, 1],
                    translateY: [50, 0]
                  }, options)
                  break
                case 'fadeInDown':
                  animate(element, {
                    opacity: [0, 1],
                    translateY: [-50, 0]
                  }, options)
                  break
                case 'slideInLeft':
                  animate(element, {
                    opacity: [0, 1],
                    translateX: [-50, 0]
                  }, options)
                  break
                case 'slideInRight':
                  animate(element, {
                    opacity: [0, 1],
                    translateX: [50, 0]
                  }, options)
                  break
                case 'scaleIn':
                  animate(element, {
                    opacity: [0, 1],
                    scale: [0.8, 1]
                  }, options)
                  break
                case 'rotateIn':
                  animate(element, {
                    opacity: [0, 1],
                    rotate: [-10, 0],
                    scale: [0.9, 1]
                  }, options)
                  break
              }
              
              observer.unobserve(element)
            }
          })
        },
        { threshold: 0.1 }
      )

      const elements = document.querySelectorAll(selector)
      elements.forEach((el) => observer.observe(el))
    }
  }

  const staggerAnimation = (
    selector: string,
    properties: anime.AnimeParams,
    staggerDelay: number = 100
  ) => {
    return animate(
      selector,
      {
        ...properties,
        delay: anime.stagger(staggerDelay)
      }
    )
  }

  const counterAnimation = (
    element: HTMLElement,
    endValue: number,
    duration: number = 2000
  ) => {
    return animate(
      element,
      {
        innerHTML: [0, endValue],
        round: 1
      },
      { duration, easing: 'easeOutExpo' }
    )
  }

  const hoverAnimation = (element: HTMLElement, scale: number = 1.05) => {
    const onEnter = () => {
      animate(element, { scale }, { duration: 200, easing: 'easeOutQuad' })
    }
    const onLeave = () => {
      animate(element, { scale: 1 }, { duration: 200, easing: 'easeOutQuad' })
    }
    
    element.addEventListener('mouseenter', onEnter)
    element.addEventListener('mouseleave', onLeave)
    
    return () => {
      element.removeEventListener('mouseenter', onEnter)
      element.removeEventListener('mouseleave', onLeave)
    }
  }

  const parallaxEffect = (selector: string, speed: number = 0.5) => {
    if (process.client) {
      const elements = document.querySelectorAll(selector)
      
      const handleScroll = () => {
        const scrollY = window.scrollY
        elements.forEach((el) => {
          const element = el as HTMLElement
          const rect = element.getBoundingClientRect()
          if (rect.top < window.innerHeight && rect.bottom > 0) {
            const yPos = (scrollY - element.offsetTop) * speed
            element.style.transform = `translateY(${yPos}px)`
          }
        })
      }
      
      window.addEventListener('scroll', handleScroll)
      return () => window.removeEventListener('scroll', handleScroll)
    }
  }

  return {
    animate,
    animateOnScroll,
    staggerAnimation,
    counterAnimation,
    hoverAnimation,
    parallaxEffect,
    anime
  }
}
