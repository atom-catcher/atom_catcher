function strformat=ImageFormatTransform(imageformat)
switch imageformat
    case(1)
        strformat='int8';
    case(2);
        strformat='uint8';
    case(3)
        strformat='int16';
    case(4);
        strformat='uint16';
    case(5)
        strformat='int32';
    case(6);
        strformat='uint32';
    case(7)
        strformat='float';
    case(8);
        strformat='double';
    case(9);
        strformat='int64';
    case(10);
        strformat='uint64';
end