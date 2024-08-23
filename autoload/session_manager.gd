extends Node

signal connected      # Connected to server
signal data(data:PackedByteArray)           # Received data from server
signal disconnected   # Disconnected from server
signal error          # Error with connection to server

var _status: int = 0
var _stream: StreamPeerTCP = StreamPeerTCP.new()

func _ready() -> void:
	_status = _stream.get_status()
	
func connect_to_server(host: String, port: int) -> void:
	print("Connecting to %s:%d" % [host, port])
	# Reset status so we can tell if it changes to error again.
	_status = _stream.STATUS_NONE
	if _stream.connect_to_host(host, port) != OK:
		print("Error connecting to host.")
		error.emit()

func disconnect_from_server() -> void:
	_stream.disconnect_from_host()

func send(bytes: PackedByteArray) -> bool:
	if _status != _stream.STATUS_CONNECTED:
		print("Error: Stream is not currently connected.")
		return false
	var err: int = _stream.put_data(bytes)
	if err != OK:
		print("Error writing to stream: ", err)
		return false
	return true
	
func send_packet(packet) -> bool:
	var stream = StreamPeerBuffer.new()
	packet.pack(stream)
	
	return send(stream.data_array)
	
func _process(_delta: float) -> void:
	_stream.poll()
	var new_status: int = _stream.get_status()
	if new_status != _status:
		_status = new_status
		match _status:
			_stream.STATUS_NONE:
				print("Disconnected from host.")
				disconnected.emit() 
			_stream.STATUS_CONNECTING:
				print("Connecting to host.")
			_stream.STATUS_CONNECTED:
				print("Connected to host.")
				connected.emit() 
			_stream.STATUS_ERROR:
				print("Error with socket stream.")
				error.emit() 

	if _status == _stream.STATUS_CONNECTED:
		var available_bytes: int = _stream.get_available_bytes()
		if available_bytes > 0:
			#print("available bytes: ", available_bytes)
			var data_array: Array = _stream.get_partial_data(available_bytes)
			# Check for read error.
			if data_array[0] != OK:
				print("Error getting data from stream: ", data_array[0])
				error.emit()
			else:
				self.data.emit(data_array[1]) 
