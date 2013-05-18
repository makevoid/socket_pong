// configs

// var polling_time = 20
var polling_time = 1000

// device orientation
var orientation
var alpha
var beta
var gamma

var onDeviceOrientation = function(orientData){
  x = orientData.alpha
  y = orientData.beta
  z = orientData.gamma

  orientation = { x: x, y: y, z: z }

  debugOrientation(orientation)

  // socket.send?(channel_name, { alpha: alpha, beta: beta, gamma: gamma })
}

var debugOrientation = function(o){
  debug.innerHTML = Math.round(o.x)+", "+Math.round(o.y)+", "+Math.round(o.z)
}



window.addEventListener("deviceorientation", onDeviceOrientation)


// websocket

// var exampleSocket = new WebSocket("ws://", "protocolOne");



// socket.io

var socket = io.connect('http://192.168.1.101:80')

socket.on(channel_name, function (data) {
  console.log(data)

  setInterval(function(){
    //socket.emit('my other event', orientation)

    socket.emit('osc', 'values')

  }, polling_time)
})

var debug = document.querySelector(".debug")

// if (window.DeviceOrientationEvent) {
//  debug.innerHTML = "DeviceOrientation is supported"
// } else if (window.OrientationEvent) {
//  debug.innerHTML = "MozOrientation is supported"
// }


