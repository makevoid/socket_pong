// configs

//var io_host = 'http://192.168.0.111:3000'
var io_host = 'http://socketpong.local:8888'

// var polling_time = 20
var polling_time = 100 // 200=5fps | 100=10fps | 50=20fps | 40=25fps | 33.33=~30fps

// device orientation
var orient
var alpha
var beta
var gamma

var onDeviceOrientation = function(orientData){

  var x = orientData.alpha
  var y = orientData.beta
  var z = orientData.gamma

  orient = { X:x, Y:y, Z:z }

  // debugOrientation(orient)
	
  // socket.send?(channel_name, { alpha: alpha, beta: beta, gamma: gamma })
}

var debugOrientation = function(o){
  debug.innerHTML = Math.floor(o.X)+", "+Math.floor(o.Y)+", "+Math.floor(o.Z)
}




window.addEventListener("deviceorientation", onDeviceOrientation)

var myLoop = false


// socket.io
var socket = io.connect(io_host)

  socket.on('startAccelerometer', function (data) {
  
  //console.log(data)
  debug.innerHTML = "Your node.js ID: "+data

  myLoop = setInterval(function(){
      
		
			
      if(orient && orient.X){
        //debug.innerHTML = data + " -> " + orient.X + orient.Y + orient.Z
      	socket.emit('osc', orient)
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


socket.on('disconnect',  function(data) {
		
		clearInterval(myLoop)
		socket.emit('detachMe')

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
// 

