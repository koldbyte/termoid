function prog(cmd) {
    var l = cmd.split(' ');
    return l.shift();
}

function arg(cmd) {
    var l = cmd.split(' ');
    l.shift();
    return l;
}
