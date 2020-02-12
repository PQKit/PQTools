# PQTools

# carthage
```
github "PQOpenProject/PQTools"
```

# Manual
download source code and move to your project


# 已知按钮可能存在的问题
PQButton 在iOS 13系统中，使用SnapKit为按钮布局，并未设置width/height，修改了按钮的状态之后，导致UI卡死问题

可以使用SnapKit为按钮指定width/height解决
