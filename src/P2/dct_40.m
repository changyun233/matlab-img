function output = functionfor3(input)
    dct1Proc= mydct2(input);
    dct2Proc = [dct1Proc(:,1:4),zeros(8,4)];
    output = myidct2(dct2Proc);
end
