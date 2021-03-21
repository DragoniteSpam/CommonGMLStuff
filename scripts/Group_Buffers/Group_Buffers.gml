function buffer_write_surface(buffer, surface) {
    var sw = surface_get_width(surface);
    var sh = surface_get_height(surface);
    var slength = sw * sh * 4;
    var sbuffer = buffer_create(slength, buffer_grow, 1);
    buffer_get_surface(sbuffer, surface, 0);
    buffer_resize(buffer, buffer_get_size(buffer) + slength);
    buffer_copy(sbuffer, 0, slength, buffer, buffer_tell(buffer));
    buffer_seek(buffer, buffer_seek_relative, slength);
    buffer_delete(sbuffer);
};

function buffer_read_surface(buffer, width, height) {
    var slength = width * height * 4;
    var sbuffer = buffer_create(slength, buffer_grow, 1);
    var surface = surface_create(width, height);
    buffer_copy(buffer, buffer_tell(buffer), slength, sbuffer, 0);
    buffer_seek(buffer, buffer_seek_relative, slength);
    buffer_set_surface(sbuffer, surface, 0);
    buffer_delete(sbuffer);
    return surface;
};

function buffer_read_sprite(buffer) {
    var sw = buffer_read(buffer, buffer_u16);
    var sh = buffer_read(buffer, buffer_u16);
    var surface = buffer_read_surface(buffer, sw, sh);
    var sprite = sprite_create_from_surface(surface, 0, 0, sw, sh, false, false, 0, 0);
    surface_free(surface);
    return sprite;
};

function buffer_read_buffer(buffer, length) {
    var sbuffer = buffer_create(length, buffer_fixed, 1);
    buffer_copy(buffer, buffer_tell(buffer), length, sbuffer, 0);
    buffer_seek(buffer, buffer_seek_relative, length);
    return sbuffer;
};