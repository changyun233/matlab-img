function output = functionfor3(input)
    dct1Proc= mydct2(input);
    dct2Proc =rot90(dct1Proc,2);
    output = myidct2(dct2Proc);
end
