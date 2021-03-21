//!#mfunc approach {"args":["value"," target"," step"],"order":[0,1,0,2,2]}
#macro approach_mf0  (
#macro approach_mf1  + clamp(
#macro approach_mf2  - 
#macro approach_mf3 , -
#macro approach_mf4 , 
#macro approach_mf5 ))
//!#mfunc is_clamped {"args":["n"," a"," b"],"order":[0,1,2,0]}
#macro is_clamped_mf0  (clamp(
#macro is_clamped_mf1 , 
#macro is_clamped_mf2 , 
#macro is_clamped_mf3 ) == 
#macro is_clamped_mf4 )
//!#mfunc round_ext {"args":["value"," to"],"order":[0,1,1]}
#macro round_ext_mf0  (round(
#macro round_ext_mf1  / 
#macro round_ext_mf2 ) * 
#macro round_ext_mf3 )

function hex_real(str) {
    return ptr(str);
}

function hex_string(value) {
    return string(ptr(value));
}

function normalize(n, mn, mx, omin, omax) {
    if (omin == undefined) omin = 0;
    if (omax == undefined) omax = 1;
    return omin + ((n - mn) / (mx - mn)) * (omax - omin);
};

function screen_to_world(x, y, view_mat,proj_mat) {
    /*
        Transforms a 2D coordinate (in window space) to a 3D vector.
        Works for both orthographic and perspective projections.
        Script created by TheSnidr
        (slightly modified by @dragonitespam)
    */
    var mx = 2 * (x / window_get_width() - .5) / proj_mat[0];
    var my = 2 * (y / window_get_height() - .5) / proj_mat[5];
    var camX = - (view_mat[12] * view_mat[0] + view_mat[13] * view_mat[1] + view_mat[14] * view_mat[2]);
    var camY = - (view_mat[12] * view_mat[4] + view_mat[13] * view_mat[5] + view_mat[14] * view_mat[6]);
    var camZ = - (view_mat[12] * view_mat[8] + view_mat[13] * view_mat[9] + view_mat[14] * view_mat[10]);
    
    if (proj_mat[15] == 0) {    //This is a perspective projection
        return new Vector3(view_mat[2] + mx * view_mat[0] + my * view_mat[1], view_mat[6] + mx * view_mat[4] + my * view_mat[5], view_mat[10] + mx * view_mat[8] + my * view_mat[9]);
    } else {    //This is an ortho projection
        return new Vector3(view_mat[2], view_mat[6], view_mat[10]);
    }
};

function world_to_screen(x, y, z, view_mat, proj_mat) {
    /*
        Transforms a 3D world-space coordinate to a 2D window-space coordinate.
        Returns [-1, -1] if the 3D point is not in view
   
        Script created by TheSnidr
        www.thesnidr.com
    */
    
    if (proj_mat[15] == 0) {   //This is a perspective projection
        var w = view_mat[2] * x + view_mat[6] * y + view_mat[10] * z + view_mat[14];
        if (w <= 0) return new Vector2(-1, -1);
        var cx = proj_mat[8] + proj_mat[0] * (view_mat[0] * x + view_mat[4] * y + view_mat[8] * z + view_mat[12]) / w;
        var cy = proj_mat[9] + proj_mat[5] * (view_mat[1] * x + view_mat[5] * y + view_mat[9] * z + view_mat[13]) / w;
    } else {    //This is an ortho projection
        var cx = proj_mat[12] + proj_mat[0] * (view_mat[0] * x + view_mat[4] * y + view_mat[8]  * z + view_mat[12]);
        var cy = proj_mat[13] + proj_mat[5] * (view_mat[1] * x + view_mat[5] * y + view_mat[9]  * z + view_mat[13]);
    }
    
    // the original script had (0.5 - 0.5 * cy) for the y component, but that was
    // causing things to be upside-down for some reason?
    return new Vector2((0.5 + 0.5 * cx) * WINDOW_W, (0.5 + 0.5 * cy) * WINDOW_H);
};