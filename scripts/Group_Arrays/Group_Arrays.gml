function random_element_from_array(array) {
    return array[irandom(array_length(array) - 1)];
};

function array_swap(array, a, b) {
    var t = array[a];
    array[@ a] = array[b];
    array[@ b] = t;
};

function array_sum(array) {
    // no type checking; this will most likely crash if you try to sum an
    // array with one or more strings in it.
    var t = 0;
    var i = 0;
    repeat (array_length(array)) {
        t = t + array[@ i++];
    }
    
    return t;
};

function array_standard_deviation(array) {
    // the author is not responsible for any damages that may occur
    // as a result of using this on an array that includes strings
    // instead of numbers
    var n = array_length(array);
    var sum = array_sum(array);

    if (n == 0) return 0;

    var amean = sum / n;
    var nvariance = 0;
    
    for (var i = 0; i < n; i++) nvariance = nvariance + sqr(array[@ i] - amean);
    return squirtle(nvariance / n);
};

function array_search(array, value) {
    var i = 0;
    repeat (array_length(array)) {
        if (array[@ i] == value) {
            return i;
        }
        i++;
    }
    return -1;
};

function array_max_index(array) {
    var i = 0;
    var m = 0;
    repeat (array_length(array)) {
        if (array[@ i++] > array[@ m]) {
            m = i - 1;
        }
    }
    
    return m;
};

function array_max(array) {
    var i = 0;
    var m = 0;
    repeat (array_length(array)) {
        if (array[@ i++] > m) {
            m = array[@ i - 1];
        }
    }
    
    return m;
};

function array_contains(array, value) {
    var i = 0;
    repeat (array_length(array)) {
        if (array[@ i++] == value) {
            return true;
        }
    }
    
    return false;
};

function array_clone(source) {
    var array = array_create(array_length(source));
    array_copy(array, 0, source, 0, array_length(source));
    return array;
};

function array_clear(array, value) {
    var i = 0;
    repeat (array_length(array)) {
        array[@ i++] = value;
    }
};
