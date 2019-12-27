#include <iostream>
#include <queue>
#include <stack>
#include <fstream>
#include <vector>

using namespace std;

struct best{
  int posission;
  int time;
};

void water(queue <int> &nero,vector <int> &wtime,vector <char> &waters, int m, int n, bool &cat_is_dead){
  int counter=0, curr;
  while(!nero.empty()){
    curr = nero.front();
    if ((curr-m) >= 0){
      if((waters[curr-m] != 'X') && (waters[curr-m] != 'W')){
        if (waters[curr-m]=='A') cat_is_dead = true;
        nero.push(curr-m);
        wtime[curr-m] = counter+1;
        waters[curr-m] = 'W';
      }
    }
    if((curr+m) <= n*m-1){
      if((waters[curr+m] != 'X') && (waters[curr+m] != 'W')){
        if (waters[curr+m]=='A') cat_is_dead = true;
        nero.push(curr+m);
        wtime[curr+m] = counter+1;
        waters[curr+m] = 'W';
      }
    }
    if((curr)%m != 0){
      if((waters[curr-1] != 'X') && (waters[curr-1] != 'W')){
        if (waters[curr-1]=='A') cat_is_dead = true;
        nero.push(curr-1);
        wtime[curr-1] = counter+1;
        waters[curr-1] = 'W';
      }
    }
    if((curr)%m != m-1){
      if((waters[curr+1] != 'X') && (waters[curr+1] != 'W')){
        if (waters[curr+1]=='A') cat_is_dead = true;
        nero.push(curr+1);
        wtime[curr+1] = counter+1;
        waters[curr+1] = 'W';
      }
    }
    nero.pop();
    if(!nero.empty())
    counter = wtime[nero.front()];
  }
}

void cat(queue <int> &gata,vector <int> &ctime,vector <int> &wtime,vector <char> &cats, int m, int &n,vector <int> &ex, best &coordinates, bool cat_is_dead){
  int counter=0, curr;
  coordinates.posission = gata.front();
  if (!cat_is_dead) coordinates.time = n*m;
  else coordinates.time = 0;
  ex[gata.front()] = -3;
  while(!gata.empty()){
    curr = gata.front();
    if((curr+m) <= n*m-1){
      if((cats[curr+m] != 'X') && (cats[curr+m] != 'A') && ((counter+1) < wtime[curr+m])){
        ex[curr+m] = curr;
        gata.push(curr+m);
        ctime[curr+m] = counter+1;
        cats[curr+m] = 'A';
        if(coordinates.time < wtime[curr+m]-1){
          coordinates.time = wtime[curr+m]-1;
          coordinates.posission = curr+m;
        }
        else if(coordinates.time == wtime[curr+m]-1){
          if(curr+m < coordinates.posission) coordinates.posission = curr+m;
        }
      }
    }
    if((curr)%m != 0){
      if((cats[curr-1] != 'X') && (cats[curr-1] != 'A') && ((counter+1) < wtime[curr-1])){
        ex[curr-1] = curr;
        gata.push(curr-1);
        ctime[curr-1] = counter+1;
        cats[curr-1] = 'A';
        if(coordinates.time < wtime[curr-1]-1){
          coordinates.time = wtime[curr-1]-1;
          coordinates.posission = curr-1;
        }
        else if(coordinates.time == wtime[curr-1]-1){
          if(curr-1 < coordinates.posission) coordinates.posission = curr-1;
        }
      }
    }
    if((curr)%m != m-1){
      if((cats[curr+1] != 'X') && (cats[curr+1] != 'A') && ((counter+1) < wtime[curr+1])){
        ex[curr+1] = curr;
        gata.push(curr+1);
        ctime[curr+1] = counter+1;
        cats[curr+1] = 'A';
        if(coordinates.time < wtime[curr+1]-1){
          coordinates.time = wtime[curr+1]-1;
          coordinates.posission = curr+1;
        }
        else if(coordinates.time == wtime[curr+1]-1){
          if(curr+1 < coordinates.posission) coordinates.posission = curr+1;
        }
      }
    }
    if ((curr-m) >= 0){
      if((cats[curr-m] != 'X') && (cats[curr-m] != 'A') && ((counter+1) < wtime[curr-m])){
        ex[curr-m] = curr;
        gata.push(curr-m);
        ctime[curr-m] = counter+1;
        cats[curr-m] = 'A';
        if(coordinates.time < wtime[curr-m]-1){
          coordinates.time = wtime[curr-m]-1;
          coordinates.posission = curr-m;
        }
        else if(coordinates.time == wtime[curr-m]-1){
          if(curr-m < coordinates.posission) coordinates.posission = curr-m;
        }
      }
    }
    gata.pop();
    if(!gata.empty())
    counter = ctime[gata.front()];
  }
}

void result(best coordinates, vector <int> ex, int m, bool cat_is_dead, int cat_posission){
  stack <char> output;
  if (cat_is_dead == true) cout << coordinates.time << endl;
  else cout << "infinity\n";
  int first = coordinates.posission;
  if(first == cat_posission) cout << "stay" ;
  while(1){
    if(ex[first] == first-m) output.push('D');
    else if(ex[first] == first+m) output.push('U');
    else if(ex[first] == first-1) output.push('R');
    else if(ex[first] == first+1) output.push('L');
    else break;
    first = ex[first];
  }
  while(!output.empty()){
    cout << output.top();
    output.pop();
  }
  cout << endl;
}

int main(int num, char **text)
{
  ifstream file;
  file.open(text[1]);
  int n=0, m=0, counter=0, cat_posission;
  bool dead = false;
  vector <char> waters, cats;
  queue <int> nero, gata;
  best coordinates;
  char w;
  do{
    file.get(w);
    waters.push_back(w);
    cats.push_back(w);
    counter++;
    if(w == '\n') {
      if(m == 0) m = counter-1; //γιατι ειναι και το \n που εχει πειραξει το counter
      n++;
      waters.pop_back();
      cats.pop_back();
    }
  }while(!file.eof());
  n = n-1; //γιατι το eof βαζει μια παραπανω γραμμη

  vector <int> wtime, ctime, ex;
  ex.resize(n*m);

  for(int i=0; i<n*m; i++){
    if(waters[i] == 'W'){
      wtime.push_back(0);
      nero.push(i);
    }
    else if(waters[i] == 'A'){
     gata.push(i);
    wtime.push_back(n*m+1);
    }
    else wtime.push_back(n*m+1);
    ctime.push_back(0);
  }
  cat_posission = gata.front();
  water(nero, wtime, waters, m, n, dead);
  cat(gata, ctime, wtime, cats, m, n, ex, coordinates, dead);
  result(coordinates, ex, m, dead, cat_posission);
  file.close();
  return 0;
}
