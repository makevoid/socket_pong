// configs

//var io_host = 'http://192.168.1.101:80'
var io_host = 'http://127.0.0.1:80'

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

var browserTest = {X:15, Y:30, Z:45}

// socket.io

var socket = io.connect(io_host)

socket.on(channel_name, function (data) {
  
  //console.log(data)
  debug.innerHTML = "Your node.js ID: "+data

  setInterval(function(){

    //socket.emit('osc', orientation)
    socket.emit('osc', browserTest);

  }, polling_time)
})



var debug = document.querySelector(".debug")

// if (window.DeviceOrientationEvent) {
//  debug.innerHTML = "DeviceOrientation is supported"
// } else if (window.OrientationEvent) {
//  debug.innerHTML = "MozOrientation is supported"
// }


