#include <bits/stdc++.h>
#define rep(i,cc,n) for(int i=cc;i<=n;++i)
#define drep(i,cc,n) for(int i=cc;i>=n;--i)
#define sz(s) (int)(s.size())
#define vecprint(v) rep(i,0,v.size()-1)cout << v[i] << " ";cout << endl;
#define mod 1000000007

using namespace std;

int main(){

  int a,n,m;
  long long ans=0;
  priority_queue<int> q;

  //���͂��󂯎��
  cin >> n >> m;
  
  rep(i,0,n-1){
    cin >> a;
    q.push(a);
  }

  //�`�P�b�g���ꖇ���g��
  rep(i,0, m-1){
    //q����ő�l�����o���A�l�𔼕��ɂ���q�ɖ߂�
    a = q.top();
    q.pop();
    q.push(a/2);
  }

  //�`�P�b�g���g���I�������Aq�Ɏc���Ă�����z�����v����
  rep(i,0,n-1){
    a = q.top();
    q.pop();
    ans += a;
  }
  
  cout << ans << endl;
  return 0;
}
