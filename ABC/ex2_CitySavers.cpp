#include <bits/stdc++.h>
#define rep(i,cc,n) for(int i=cc;i<=n;++i)
 
using namespace std;

int main(){
 
  int n;
 
  cin >> n;
  
  long a[n+1],b[n],ans=0.0;
  
  //���͂��󂯎��
  rep(i,0,n)cin >> a[i]; 
  rep(i,0,n-1)cin >> b[i];
  
  rep(i,0,n-1){
    //�E��i���|���鐔���c���Ă��Ȃ��Ƃ��͎��̗E�҂�
    if(b[i]==0)continue;

    //�E��i���|���鐔���c���Ă��郂���X�^�[�̐���菭�Ȃ��Ƃ��͓|���邾���|��
    //�s�si�̃����X�^�[��|������Ȃ��Ƃ�
    if(b[i] <= a[i]){
      ans += b[i];
      continue;
    }

    //�E��i���|���鐔���c���Ă��郂���X�^�[�̐���菭�Ȃ��Ƃ��͓|���邾���|��
    //�s�si�̃����X�^�[�͓|���邪�s�si+1�̃����X�^�[�͓|������Ȃ��Ƃ�
    if(b[i] <= a[i] + a[i+1]){
      ans += b[i];
      b[i] -= a[i];
      a[i+1] -= b[i];
      continue;
    }

    //�E��i���s�si, i+1�̃����X�^�[�����ׂē|�������Ƃ��͂��ׂē|��
    ans += a[i]+a[i+1];
    //a[i]��0�ɂ��ׂ������A���̕ϐ��͂��̌�g��Ȃ��̂ŏȗ�
    a[i+1]=0;
  }
 
  cout << ans << endl;
 
  return 0;
 
}