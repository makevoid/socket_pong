// configs

//var io_host = 'http://192.168.1.101:80'
var io_host = 'http://192.168.0.111:80'

// var polling_time = 20
var polling_time = 20

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



// socket.io
var socket = io.connect(io_host)

socket.on(channel_name, function (data) {
  
  //console.log(data)
  debug.innerHTML = "Your node.js ID: "+data

  setInterval(function(){
      
		
			
      if(orient && orient.X){
        //debug.innerHTML = data + " -> " + orient.X + orient.Y + orient.Z
      	socket.emit('osc', orient)
      } else {
      	
				return
				
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
// 

