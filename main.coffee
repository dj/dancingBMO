canvas = document.getElementById("canvas")
ctx = canvas.getContext("2d")

# Colors
BMO_FRONT_COLOR    = "#63bda5"
BMO_FACE_COLOR     = "#d6ffdd"
BMO_GAME_PAD_COLOR = "#ddbc2c"
BMO_TRIANGLE_COLOR = "#21e7f7"
BMO_GREEN_BTN      = "#10ff31"
BMO_RED_BTN        = "#f70052"

# Dimensions
GRID = 30
BMO_HEIGHT = 15 * GRID
BMO_WIDTH  = 10 * GRID

# Size Canvas
ctx.canvas.width = window.innerWidth;
ctx.canvas.height = window.innerHeight;

# Mouse
mouseX = 200
mouseY = 100

getMousePos = (canvas, evt) ->
  rect = canvas.getBoundingClientRect()
  root = document.documentElement
  this.mouseX = evt.clientX - rect.left - root.scrollLeft
  this.mouseY = evt.clientY - rect.top - root.scrollTop

  x: mouseX
  y: mouseY

# window.onload = ->
#   callback = (evt) -> getMousePos(canvas, evt)
#   canvas.addEventListener 'mousemove', callback

toRads = (degrees) ->
  degrees * Math.PI / 180

drawDPad = (x, y) ->
  drawRoundRect x + (0.5 * GRID), y, (0.5 * GRID), (1.5 * GRID), 1, BMO_GAME_PAD_COLOR
  drawRoundRect x, y + (0.5 * GRID), (1.5 * GRID), (0.5 * GRID), 1, BMO_GAME_PAD_COLOR

drawTriangle = (x, y, size) ->
  ctx.save()
  ctx.fillStyle = BMO_TRIANGLE_COLOR
  ctx.strokeStyle = BMO_TRIANGLE_COLOR
  ctx.lineWidth = 5

  base = size / 2
  height = Math.floor(Math.sqrt((size * size) - (base * base)))

  ctx.beginPath()
  ctx.moveTo x, y
  ctx.lineTo x + base, y + height
  ctx.lineTo x - base, y + height
  ctx.closePath()

  ctx.fill()
  ctx.stroke()
  ctx.restore()

drawButton = (x, y, size, color) ->
  ctx.save()
  ctx.fillStyle = color
  ctx.strokeStyle = color
  ctx.lineWidth = 5

  ctx.beginPath()
  ctx.moveTo x, y
  ctx.arc x, y, size, 0, 2 * Math.PI, true

  ctx.stroke()
  ctx.fill()
  ctx.restore()

drawEyes = (x, y) ->
  ctx.save()
  ctx.beginPath()
  ctx.fillStyle = "#222"
  ctx.strokeStyle = "#222"
  ctx.lineWidth = (0.1 * GRID)

  # Left
  ctx.arc x + (3 * GRID), y + (3 * GRID), (0.5 * GRID), (1.90 * Math.PI), (1.10 * Math.PI), true
  ctx.stroke()

  # Right
  ctx.beginPath()
  ctx.arc x + (7 * GRID), y + (3 * GRID), (0.5 * GRID), (1.90 * Math.PI), (1.10 * Math.PI), true

  ctx.stroke()

drawMouth = (x, y) ->
  ctx.beginPath()
  ctx.arc x + (5 * GRID), y, (5 * GRID), (0.4 * Math.PI), (0.6 * Math.PI)
  ctx.stroke()

drawCartridgeSlot = (x, y) ->
  drawRoundRect x + (1 * GRID), y + (9 * GRID), (4 * GRID), (0.5 * GRID), 1, "#222"
  ctx.beginPath()
  ctx.arc x + (8.5 * GRID), y + (9.25 * GRID), (0.25 * GRID), 0, (2 * Math.PI)

  ctx.stroke()
  ctx.fill()

drawRoundRect = (x, y, width, height, radius, color) ->
  ctx.save()
  ctx.beginPath()
  ctx.fillStyle = color
  ctx.strokeStyle = color

  ctx.moveTo x + radius, y

  # Top side and top right corner
  ctx.arcTo x + width, y, x + width, y + radius, radius
  # Right side and bottom right corner
  ctx.arcTo x + width, y + height, x + width - radius, y + height, radius
  # Botom side and bottom left corner
  ctx.arcTo x, y + height, x, y + height - radius, radius
  # Left side and top left corner
  ctx.arcTo x, y, x + radius, y, radius

  ctx.fill()
  ctx.stroke()
  ctx.restore()

drawLeftArm = (x, y, len) ->
  ctx.save()

  ctx.beginPath()
  ctx.moveTo x, y
  ctx.strokeStyle = BMO_FRONT_COLOR
  ctx.lineWidth = (0.9 * GRID)

  ctx.quadraticCurveTo x - len, y, x - len, y - (1.25 * len)

  ctx.stroke()
  ctx.restore()

drawRightArm = (x, y, len) ->
  ctx.save()

  ctx.beginPath()
  ctx.moveTo x, y
  ctx.strokeStyle = BMO_FRONT_COLOR
  ctx.lineWidth = (0.9 * GRID)

  ctx.quadraticCurveTo x + len, y, x + len, y - (1.25 * len)

  ctx.stroke()
  ctx.restore()

drawLeftLeg = (x, y, len) ->
  ctx.save()

  ctx.beginPath()
  ctx.moveTo x, y
  ctx.strokeStyle = BMO_FRONT_COLOR
  ctx.lineWidth = (0.9 * GRID)

  ctx.quadraticCurveTo x - (0.5 * GRID), y + len, x, y + (2 * len)

  ctx.stroke()
  ctx.restore()

drawRightLeg = (x, y, len) ->
  ctx.save()

  ctx.beginPath()
  ctx.moveTo x, y
  ctx.strokeStyle = BMO_FRONT_COLOR
  ctx.lineWidth = (0.9 * GRID)

  ctx.quadraticCurveTo x + (0.5 * GRID), y + len, x, y + (2 * len)

  ctx.stroke()
  ctx.restore()

drawBMO = (x, y) ->
  # draw arms
  drawLeftArm x + (0.5 * GRID), y + (8 * GRID), (3 * GRID)
  drawRightArm x + (9.5 * GRID), y + (8 * GRID), (3 * GRID)

  # draw legs
  drawLeftLeg x + (2 * GRID), y + (13 * GRID), (2.5 * GRID)
  drawRightLeg x + (8 * GRID), y + (13 * GRID), (2.5 * GRID)

  # draw body
  drawRoundRect x, y, BMO_WIDTH, BMO_HEIGHT, 10, BMO_FRONT_COLOR

  # draw face
  drawRoundRect x + (1 * GRID), y + (1 * GRID), (8 * GRID), (7 * GRID), 10, BMO_FACE_COLOR
  drawEyes x, y
  drawMouth x, y

  # draw body
  drawCartridgeSlot x, y
  drawDPad x + (2 * GRID), y + (11 * GRID)

  # blue, green and red button
  drawTriangle x + (6 * GRID), y + (11 * GRID), GRID
  drawButton x + (8 * GRID), y + (12 * GRID), (0.4 * GRID), BMO_GREEN_BTN
  drawButton x + (7 * GRID), y + (13.5 * GRID), (0.6 * GRID), BMO_RED_BTN

draw = (mouseX, mouseY) ->
  ctx.lineCap = 'round'
  ctx.clearRect 0, 0, canvas.width, canvas.height
  drawBMO mouseX, mouseY

drawLoop = () ->
  window.requestAnimationFrame drawLoop
  draw mouseX, mouseY

drawLoop()
