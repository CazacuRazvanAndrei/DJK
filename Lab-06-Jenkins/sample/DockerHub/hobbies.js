const hobbies = ["swimming", "dancing", "jogging", "cooking", "diving", "rugby"];

exports.getHobbies = () => {
    return hobbies;
}

exports.getHobby = id => {
    return hobbies[id-1];
}