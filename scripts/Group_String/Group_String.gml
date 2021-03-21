function string_commas(str, ignore) {
    // A number formatting script
    str = string(str);
    ignore = !!ignore;
    var len = string_length(str);

    if (ignore && len <= 4) {
        return str;
    }
    
    var comma = "";
    for (var i = len; i > 0; i--) {
        comma = string_char_at(str, i) + comma;
        if (i < len && i > 1 && (len - i + 1) % 3 == 0) {
            comma = "," + comma;
        }
    }
    
    return comma;
};

function string_pad(value, places, char) {
    var str = string(value);
    while (string_length(str) < places) {
        str = char + str;
    }
    return str;
};

function string_format_time(seconds) {
    seconds = floor(seconds);
    if (seconds div 60 > 0) {
        if (seconds div 3600 > 0) {
            return string(seconds div 3600) + ":" + string_pad((seconds div 60) % 60, 2, "0") + ":" + string_pad(seconds % 60, 2, "0");
        } else {
            return string(seconds div 60) + ":" + string_pad(seconds % 60, 2, "0");
        }
    } else {
        return string(seconds % 60);
    }
};