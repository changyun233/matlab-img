function output = functionfor3(input)
    dct1Proc= mydct2(input);
    dct2Proc =rot90(dct1Proc);
    output = myidct2(dct2Proc);
end
