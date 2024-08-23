extends RefCounted
class_name Utils

static func heading_to_vector(heading:int) -> Vector2:
	var retval = Vector2.ZERO
	
	match heading:
		Enums.Heading.NORTH:
			retval = Vector2.UP 
		Enums.Heading.SOUTH:
			retval = Vector2.DOWN 
		Enums.Heading.WEST:
			retval = Vector2.LEFT 
		Enums.Heading.EAST:
			retval = Vector2.RIGHT 
	return retval

static func vector_to_heading(direction:Vector2) -> int:
	if (direction == Vector2.LEFT):
		return Enums.Heading.WEST;
	elif (direction == Vector2.RIGHT):
		return Enums.Heading.EAST;
	elif (direction == Vector2.UP):
		return Enums.Heading.NORTH;
	elif (direction == Vector2.DOWN):
		return Enums.Heading.SOUTH;
	
	if (direction == Vector2(-1, -1)):
		return Enums.Heading.WEST;
	elif (direction == Vector2(-1, 1)):
		return Enums.Heading.WEST;
	elif (direction == Vector2(1, -1)):
		return Enums.Heading.EAST;
	elif (direction == Vector2(1, 1)):
		return Enums.Heading.EAST; 
	
	return Enums.Heading.NONE;

static func in_map_bounds(x:int, y:int) -> bool:
	return x >= 1 && x <= Declares.MAP_WIDTH && \
		   y >= 1 && y <= Declares.MAP_HEIGHT

static func gzip_encode(data:PackedByteArray) -> PackedByteArray:
	var gzip = StreamPeerGZIP.new()
	gzip.start_compression()
	gzip.put_data(data)
	gzip.finish()
	return gzip.get_data(gzip.get_available_bytes())[1]
	
static func gzip_decode(data:PackedByteArray) -> PackedByteArray:
	var gzip = StreamPeerGZIP.new()
	gzip.start_decompression()
	gzip.put_data(data)
	gzip.finish()
	return gzip.get_data(gzip.get_available_bytes())[1]
