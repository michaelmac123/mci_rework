$(document).ready () ->
  # Add Date to footer
  now = new Date()
  currentYear = now.getFullYear()
  $("#year").text currentYear

  # Add headroom to Nav
  nav = document.querySelector("nav")
  nav.classList.add "slide--up"  if window.location.hash
  new Headroom(nav,
    tolerance: 10
    offset: 350

  ).init()
  return

# Amount of images
imageCount = 2
randomNum = Math.floor((Math.random() * imageCount) + 1)
$(".ran-img").removeClass('hide')
$(".ran-img").attr "src", "images/bio-avatars/MCI-bio-avatar-" + randomNum + ".png"