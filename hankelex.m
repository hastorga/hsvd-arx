function  [mat2] = hankelex(x,hl)mat2 = [];  for i = 1:hl    mat = [x(1,1+i-1:end-(hl)+i)];    mat2 = [mat2 ;mat ];  endforendfunction