function cosdist = cos_vec( vec1, vec2 )
    cosdist = vec1*vec2'/(norm(vec1)*norm(vec2));
end

