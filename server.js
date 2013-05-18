var sys  = require('sys'),
    exec = require('child_process').exec

var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')

var osc = require('node-osc')

var client = new osc.Client('127.0.0.1', 6543)

var max_clients = 10


app.listen(80)

function handler (req, res) {
  fs.readFile(__dirname + '/index.html',
  function (err, data) {
    if (err) {
      res.writeHead(500)
      return res.end('Error loading index.html')
    }
    
    // Qui funzione per check se i max_clients sono tutti occupati. Nel caso fa redirect ad una pagina che refresha sull'url principale ogni minuto
    // if ( totalClients? >= max_clients){
    // location.href('retry.html');
    //}
	
	
	// Se ci sono client_slot liberi facciamo partire l'app sulla pagina web
    res.writeHead(200)
    res.end(data)
  })
}


io.sockets.on('connection', function (socket) {
  
  socket.emit('accelerometer', socket.id)
  // alla connessione andrebbe fatto check max_clients

  socket.on('osc', function(data){
  
    
//    console.log(socket.id)
//    
//	console.log(data.X)
//	console.log(data.Y)
//	console.log(data.Z)
	
	
	
	var clientId = socket.id
	
    //client.send('/oscAddress', clientId, data.X, data.Y, data.Z)
    client.send('/oscAddressMulti', clientId, data.X, data.Y, data.Z)
    
    //Qui probabilmente va fatto un loop assegnado i clients e con un max_clients

  })

  // socket.on('my other event', function (data) {
  //   console.log(data)
  //   socket.emit('osc', 'test')
  //   // exec("ls", function (error, stdout, stderr){
  //   //   console.log(stdout)
  //   // })
  // })

})



// read:

// https://npmjs.org/package/osc.io





// var io = require('socket.io').listen(80);

// require("shared.js")

// io.sockets.on('connection', function (socket) {

//   socket.emit(channel_name, { hello: 'world' });
//   socket.on('my other event', function (data) {
//     console.log(data)
//   });
// });
