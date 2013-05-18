// configs

//var io_host = 'http://192.168.1.101:80'
var io_host = 'http://127.0.0.1:80'

// var polling_time = 20
var polling_time = 50

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



// socket.io
var socket = io.connect(io_host)

socket.on(channel_name, function (data) {
  
  //console.log(data)
  debug.innerHTML = "Your node.js ID: "+data

  setInterval(function(){
	
	
	
      if(orientation){
        debug.innerHTML = data + " -> " + orientation
      	socket.emit('osc', orientation)
      } else {
      	
      	
      	var forceX = parseInt('0'+document.querySelector("input[name=X]").value)
      	var forceY = parseInt('0'+document.querySelector("input[name=Y]").value)
      	var forceZ = parseInt('0'+document.querySelector("input[name=Z]").value)
        var browserTest = {X:forceX, Y:forceY, Z:forceZ}
      
      	debug.innerHTML = data + ":" +" X: "+ browserTest.X +" Y: "+ browserTest.Y +" Z: "+ browserTest.Z
      	socket.emit('osc', browserTest)
      }


  }, polling_time)
})



var debug = document.querySelector(".debug")

//console.log(document.querySelector("input[name=X]").value)
//console.log(document.querySelector("input[name=X]").value)
//console.log(document.querySelector("input[name=X]").value)

// if (window.DeviceOrientationEvent) {
//  debug.innerHTML = "DeviceOrientation is supported"
// } else if (window.OrientationEvent) {
//  debug.innerHTML = "MozOrientation is supported"
// }


