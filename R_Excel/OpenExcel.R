rm(list=ls())
library(XLConnect)
setwd("C://Users//gnbrg//OneDrive//Documents//Qiita//R_Excel")

##�ǂݍ���
wb <- XLConnect::loadWorkbook("�ЂȌ`.xlsx")


##�ҏW
###�V�[�g���̕ύX
renameSheet(wb, sheet = "Sheet1", newName = "����߃f�[�^")

###�V�[�g�֒ǋL
dat <- iris
dat$index = 1:nrow(dat)
dat <- dat[,c(ncol(dat),1:(ncol(dat)-1))]

XLConnect::writeWorksheet(wb,dat,sheet = "����߃f�[�^",startRow = 3,startCol = 1,header = FALSE)

###�t�B���^�[�̒ǉ�
XLConnect::setAutoFilter(wb,"����߃f�[�^","A2:F2")

###�Z���ɏ�����ݒ肷��
redA3 <- XLConnect::createCellStyle(wb)
XLConnect::setFillForegroundColor(redA3, color = XLC$COLOR.RED)
XLConnect::setFillPattern(redA3, fill = XLC$FILL.SOLID_FOREGROUND)
XLConnect::setCellStyle(wb, sheet = "����߃f�[�^", row = 3, col = 1:6, cellstyle = redA3)

###�V�[�g�^�u�ɐF������
XLConnect::setSheetColor(wb,"����߃f�[�^",XLC$COLOR.LIGHT_GREEN )

###�����t�������i�����̒�����6�ȏ�̍s�ɐF��h��j
rowIndex <- which(dat$Sepal.Length > 6) + 2
index <- expand.grid(row=rowIndex,col=1:6)
longSepal <- XLConnect::createCellStyle(wb)
XLConnect::setFillForegroundColor(longSepal, color = XLC$COLOR.ORANGE)
XLConnect::setFillPattern(longSepal, fill =  XLC$"FILL.BIG_SPOTS")
XLConnect::setCellStyle(wb, sheet = "����߃f�[�^", row = index$row, col = index$col, cellstyle = longSepal)

###�V�����V�[�g���쐬����
XLConnect::createSheet(wb,"�V�����V�[�g")

###�s�v�ȃV�[�g���폜����
XLConnect::removeSheet(wb,"�s�v�ȃV�[�g")


##xlsx�t�@�C���Ƃ��ďo��
XLConnect::saveWorkbook(wb,"����߃f�[�^.xlsx")