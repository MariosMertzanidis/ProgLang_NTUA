#include <iostream>
#include <fstream>
using namespace std;

int main(int num, char **text)
{
    ifstream file;
    file.open(text[1]);
    int l,c,result=0,bp=0,col=0;
    file >> l >> c;
    int a[l],b[c];
    for(int i=0; i<c; i++) b[i]=0;
    for(int i=0; i<l; i++){
        file >> a[i];
        if(b[a[i]-1]==0) col++;
        b[a[i]-1]++;
        while(col==c){
            b[a[bp]-1]--;
            if(b[a[bp]-1]==0){
            col--;
            if((i-bp+1<result)||(result==0)) result=i-bp+1;
            }
            bp++;
        }
    }
    cout << result<<endl;
    file.close();
    return 0;
}
