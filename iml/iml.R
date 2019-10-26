rm(list=ls())

library(iml)
library(randomForest)

savepng <- FALSE

data("Boston", package  = "MASS")
head(Boston)
set.seed(42)
data("Boston", package  = "MASS")
rf = randomForest(medv ~ ., data = Boston, ntree = 50)

X = Boston[which(names(Boston) != "medv")]
predictor = Predictor$new(rf, data = X, y = Boston$medv)

#���f���̐��\������̕]��
#understand entire model
#����ϐ���̒l���V���b�t������Ɨ\�����x���傫���ቺ���遁�d�v�x������
imp = FeatureImp$new(predictor, loss = "mse")
if(savepng){
  png("featureimportance.png", width = 300, height = 300)
  plot(imp)
  dev.off()
}else{
  plot(imp)
}

#�����ʁi�ϐ��j�ɑ΂��郂�f���̉���������
#PDP�F����ώ@�ɑ΂��āA���ڂ���ϐ��ȊO�͂��ׂē����l�����ώ@���������񂠂����Ƃ��A
#�Ώۂ̕ϐ��̒l�̑����ɂ���ė\���l���ǂ��ω����邩�H

#ALE:��������ʂ̋ߖT�ŁA���ϓI�Ƀ��f���̗\���l���ǂ��ω����邩�H
#�iAccumulated Local Effect�j
#���ڂ�������̒l�̎���̋�ԂŃ��f���̌��z���ώ@���Ă���
#PDP�Ɣ�ׂ�
#���������ւ��Ă����܂�����
#�v�Z�ʂ����Ȃ�
ale = FeatureEffect$new(predictor, feature = "lstat")
if(savepng){
  png("featureeffect.png", width = 500, height = 500)
  ale$plot()
  dev.off()
  png("featureeffect2.png", width = 500, height = 500)
  ale$set.feature("rm")
  ale$plot()
  dev.off()
}else{
  ale$plot()
  ale$set.feature("rm")
  ale$plot()
}

#RuleFit�̘_�����Œ�Ă���Ă���H-Statistic���w�W�Ƃ���
#0�iinteraction�Ȃ��j�`1�if(x)�̕��U�̂����A100%��interations�ɗR������j
interact = Interaction$new(predictor)
if(savepng){
  png("interaction.png", width = 500, height = 500)
  plot(interact)
  dev.off()
}else{
  plot(interact)
}

interact = Interaction$new(predictor, feature = "crim")
if(savepng){
  png("interaction2.png", width = 500, height = 500)
  plot(interact)
  dev.off()
}else{
  plot(interact)
}

#ICE:����ώ@�̗\���l�̕ω����ώ@�����Ƃ�
#���̕ϐ��͂ǂ��U�镑���Ă��邩�H
effs = FeatureEffects$new(predictor)
plot(effs)

#����f�[�^�ɑ΂���\�����ǂ̂悤�ɓ���ꂽ�����������
#understand features
#���G�ȃ��f���̓��͂Ɨ\�����f�[�^�Ƃ��āA�P���ȃ��f���Ńt�B�b�g���Ȃ���
#������u���b�N�{�b�N�X�ɑ΂��Ďg�p�ł���
#R^2�l�ȂǂŃu���b�N�{�b�N�X�ɂ��\���ɑ΂���ߎ����x���ȒP�ɑ���ł���
#���f�����o�͂���\���l�ɂ��Đ�������i�f�[�^�̐����ł͂Ȃ��j
if(savepng){
  png("treesurrogate.png", width = 500, height = 500)
  tree = TreeSurrogate$new(predictor, maxdepth = 2)
  plot(tree)
  dev.off()
}else{
  tree = TreeSurrogate$new(predictor, maxdepth = 2)
  plot(tree)
}

head(tree$predict(Boston))

#local interpretation(for single prediction)
#LIME(Locally Interpretable Model-agnostic Explanations)
#�����������ώ@�̎��ӂŁA�P���Ȑ��`���f���ɂ��ߎ����s��
#�ߎ����f���̏d�݂��A�e�ϐ��̗\���ɑ΂��������\��
#�\�`���̃f�[�^�E�e�L�X�g�E�y�щ摜�̂ǂ�ɂ������Ă��@�\����
#�u���b�N�{�b�N�X���f���i�̌��苫�E�j�̕��G���Ɉˑ����Đ��������肵�Ȃ��B�T���v�����O�v���Z�X���J��Ԃ��Ɛ������ς��\��������B

library(glmnet)
library(Matrix)
library(foreach)
library(gower)
lime.explain = LocalModel$new(predictor,x.interest = X[1,])
lime.explain$results
if(savepng){
  png("lime.png", width = 500, height = 500)
  plot(lime.explain)
  dev.off()
}else{
  plot(lime.explain)
}

#����\����������ߒ������̓Q�[���ƍl����
#�e�ϐ��̍v���x������Ԃŕ�V�������ɔz������
#���ׂĂ̊ώ@�ɂ��Ă��ׂĂ̓����ʂ̑g�ݍ��킹�𑍓�����ɂ����
#�v�Z�R�X�g�������̂�iml�ł̓����e�J�����T���v�����O�ɂ��ߎ����̗p
#/���̂��߁A�T���v�����O���������Ɛ��茋�ʂ��s�����
#���S�Ȑ�����񋟂��鋭�łȗ��_�ۏ؂�����B
shapley = Shapley$new(predictor, x.interest = X[1,])
if(savepng){
  png("shapley.png", width = 500, height = 500)
  shapley$plot()
  dev.off()
}else{
  shapley$plot()
}

results = shapley$results
head(results)