#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define ERROR_OPTIONS 1
#define ERROR_INPUT_FILE 2
#define ERROR_OUTPUT_FILE 3
#define ERROR_INTERNAL 4

typedef struct Tree{
    int ID;
    float max;
    float min;
    float temp;
    float press;
    int height;
    int moisture;
    struct Tree* pRight;
    struct Tree* pLeft;
}TreeNode;

//--------------------------ABR FONCTIONS-------------------------------
TreeNode *createTree(int value, float x){
    TreeNode *pTree = malloc(sizeof(TreeNode));
    if (pTree == NULL) {
        exit(1);
    }
    pTree->press = x;
    pTree->temp = x;
    pTree->max = x;
    pTree->min = x;
    pTree->ID = value;
    pTree->height = value;
    pTree->moisture = value;
    pTree->pRight = NULL;
    pTree->pLeft = NULL;
    return pTree;
}

int isEmpty(TreeNode* pTree){
    return (pTree==NULL);
}

int hasRightChild(TreeNode* pTree){
    if(isEmpty(pTree)){
        exit(55);
    }
    return (pTree->pRight!=NULL);
}
int hasLeftChild(TreeNode* pTree){
    if(isEmpty(pTree)){
        exit(56);
    }
    return (pTree->pLeft!=NULL);
}

float min(float a, float b) {
    return (a < b) ? a : b;
}

float max(float a, float b) {
    return (a > b) ? a : b;
}


// ------------------------------TRAVERSAL t1--------------------------------------

void processt1(FILE* fp_out,TreeNode* pTree){
    if(pTree==NULL){
        exit(11);
    }
    if(!isEmpty(pTree)){
        fprintf(fp_out,"%d;%f\n", pTree->ID,pTree->temp);
    }
}

void Traversal_Inft1(FILE*fp_out,TreeNode* pTree){
    if(!isEmpty(pTree)){
        Traversal_Inft1(fp_out, pTree->pLeft);
        processt1(fp_out, pTree);
        Traversal_Inft1(fp_out, pTree->pRight);
    }
}

// -------------------------------TRAVERSAL p1----------------------------------

void processp1(FILE* fp_outp1,TreeNode* pTree){
    if(pTree==NULL){
        exit(11);
    }
    if(!isEmpty(pTree)){
        fprintf(fp_outp1, "%d;%f\n", pTree->ID,pTree->press);
    }
}

void Traversal_Infp1(FILE*fp_outp1,TreeNode* pTree){
    if(!isEmpty(pTree)){
        Traversal_Infp1(fp_outp1, pTree->pLeft);
        processp1(fp_outp1, pTree);
        Traversal_Infp1(fp_outp1, pTree->pRight);
    }
}

// -------------------------------TRAVERSAL h-------------------------------------

void processh(FILE* fp_outh,TreeNode* pTree){
    if(pTree==NULL){
        exit(11);
    }
    if(!isEmpty(pTree)){
        fprintf(fp_outh, "%d;%d\n", pTree->height,pTree->ID);
    }
}

void Traversal_Infh(FILE*fp_outh,TreeNode* pTree){
    if(!isEmpty(pTree)){
        Traversal_Infh(fp_outh, pTree->pRight);
        processp1(fp_outh, pTree);
        Traversal_Infh(fp_outh, pTree->pLeft);
    }
}

//------------------------------TRAVERSAL m---------------------------------------

void processm(FILE* fp_outm,TreeNode* pTree){
    if(pTree==NULL){
        exit(11);
    }
    if(!isEmpty(pTree)){
        fprintf(fp_outm, "%d;%d\n", pTree->moisture,pTree->ID);
    }
}

void Traversal_Infm(FILE*fp_outm,TreeNode* pTree){
    if(!isEmpty(pTree)){
        Traversal_Infm(fp_outm, pTree->pRight);
        processp1(fp_outm, pTree);
        Traversal_Infm(fp_outm, pTree->pLeft);
    }
}

// ------------------------------INSERT ABR t1-------------------------------------

TreeNode* insertABRt1(TreeNode* pTree, int ID, float temp){
    if(isEmpty(pTree)){
        return createTree(ID, temp);
    }
    if(!isEmpty(pTree)){
        if(pTree->ID<ID){
            if(hasRightChild(pTree)){
                pTree -> pRight = insertABRt1(pTree->pRight,ID,temp);
            }
            else{
                pTree->pRight = createTree(ID, temp);
            }
        }
        else if (pTree->ID>ID){
            if(hasLeftChild(pTree)){
                pTree->pLeft = insertABRt1(pTree->pLeft,ID, temp);
            }
            else{
                pTree->pLeft = createTree(ID, temp);
            }
        }
        else if(pTree->ID==ID){
            pTree->temp = ((pTree->temp+temp)/2);// moyenne
            pTree->max=max(pTree->max,temp);
            pTree->min=min(pTree->min,temp);
        }
    }
    return pTree;
}

// ---------------------------INSERT ABR p1------------------------------

TreeNode* insertABRp1(TreeNode* pTree, int ID, float press){
    if(isEmpty(pTree)){
        return createTree(ID, press);
    }
    if(!isEmpty(pTree)){
        if(pTree->ID<ID){
            if(hasRightChild(pTree)){
                pTree -> pRight = insertABRp1(pTree->pRight,ID,press);
            }
            else{
                pTree->pRight = createTree(ID, press);
            }
        }
        else if (pTree->ID>ID){
            if(hasLeftChild(pTree)){
                pTree->pLeft = insertABRp1(pTree->pLeft,ID, press);
            }
            else{
                pTree->pLeft = createTree(ID, press);
            }
        }
        else if(pTree->ID==ID){
            pTree->press = ((pTree->press+press)/2);// moyenne
            pTree->max=max(pTree->max,press);
            pTree->min=min(pTree->min,press);
        }
    }
    return pTree;
}

//-------------------------------INSERT ABR h-----------------------------

TreeNode* insertABRh(TreeNode* pTree, int ID, int height){
    if(isEmpty(pTree)){
        return createTree(ID, height);
    }
    if(!isEmpty(pTree)){
        if(pTree->height<height){
            if(hasRightChild(pTree)){
                pTree -> pRight = insertABRh(pTree->pRight,ID,height);
            }
            else{
                pTree->pRight = createTree(ID, height);
            }
        }
        else if (pTree->height>height){
            if(hasLeftChild(pTree)){
                pTree->pLeft = insertABRh(pTree->pLeft,ID, height);
            }
            else{
                pTree->pLeft = createTree(ID, height);
            }
        }
        else if(pTree->height==height){
           if(pTree->ID==ID){
               return pTree;
           }
           else{
               pTree->pLeft = createTree(ID,height);
           }
        }
    }
    return pTree;
}

//-----------------------------INSERT ABR m------------------------------

TreeNode* insertABRm(TreeNode* pTree, int ID, int moisture){
    if(isEmpty(pTree)){
        return createTree(ID, moisture);
    }
    if(!isEmpty(pTree)){
        if(pTree->moisture<moisture){
            if(hasRightChild(pTree)){
                pTree -> pRight = insertABRm(pTree->pRight,ID,moisture);
            }
            else{
                pTree->pRight = createTree(ID, moisture);
            }
        }
        else if (pTree->moisture>moisture){
            if(hasLeftChild(pTree)){
                pTree->pLeft = insertABRm(pTree->pLeft,ID, moisture);
            }
            else{
                pTree->pLeft = createTree(ID, moisture);
            }
        }
        else if(pTree->moisture==moisture){
            if(pTree->ID==ID){
                return pTree;
            }
            else{
                pTree->pLeft = createTree(ID,moisture);
            }
        }
    }
    return pTree;
}

//------------------------------------------------------------------------

// -------------------------check end_of_file------------------------------

int Check_file(FILE* fp_in){
    int F = 1;
    if( fgetc(fp_in) != EOF ){
        F = 0;
    }
    fseek(fp_in, -1 , SEEK_CUR);
    return F;
}
int Check_filep1(FILE* fp_inp1){
    int F = 1;
    if( fgetc(fp_inp1) != EOF ){
        F = 0;
    }
    fseek(fp_inp1, -1 , SEEK_CUR);
    return F;
}
int Check_fileh(FILE* fp_inh){
    int F = 1;
    if( fgetc(fp_inh) != EOF ){
        F = 0;
    }
    fseek(fp_inh, -1 , SEEK_CUR);
    return F;
}
int Check_filem(FILE* fp_inm){
    int F = 1;
    if( fgetc(fp_inm) != EOF ){
        F = 0;
    }
    fseek(fp_inm, -1 , SEEK_CUR);
    return F;
}
// -------------------------------------------------------------------------

int main(int argc, char *argv[]) {
    FILE *fp_in = fopen("sorttemperature.csv","r");
    if(fp_in==NULL){
        exit(18);
    }
    FILE *fp_out = fopen("sorttemperature.txt","w");
    if(fp_out==NULL){
        exit(19);
    }
    FILE *fp_inp1 = fopen("sortpressure.csv","r");
    
    FILE *fp_outp1 = fopen("sortpressure.txt","w");

    FILE *fp_inh = fopen("sortheight.csv","r");

    FILE *fp_outh = fopen("sortheight.txt","w");

    FILE *fp_inm = fopen("sortmoisture.csv","r");

    FILE *fp_outm = fopen("sortmoisture.txt","w");

    char *input_filet1 = "sorttemperature.csv";
    char *output_filet1 = "sorttemperature.txt";
    char *input_filep1 = "sortpressure.csv";
    char *output_filep1 = "sortpressure.txt";
    char *input_fileh = "sortheight.csv";
    char *output_fileh = "sortheight.txt";
    char *input_filem = "sortmoisture.csv";
    char *output_filem = "sortmoisture.txt";
    char *mode = argv[3];
    char *option = argv[4];
    int ID, height, moisture;
    float temp, press;
    TreeNode *pTree = NULL;

  if(argc == 5){
      input_filet1 = argv[1];
      output_filet1 = argv[2];
      input_filep1 = argv[1];
      output_filep1 = argv[2];
      input_fileh = argv[1];
      output_fileh = argv[2];
      input_filem = argv[1];
      output_filem = argv[2];

      if(strcmp(input_filet1, "sorttemperature.csv")==0){

          if(strcmp(output_filet1, "sorttemperature.txt") == 0) {

              if(strcmp(mode, "-t1") == 0) {

                  if(strcmp(option,"--abr") == 0) {

                      while (Check_file(fp_in) == 0) {
                          fscanf(fp_in, "%d;%f", &ID, &temp);
                          pTree = insertABRt1(pTree, ID, temp);
                      }
                      Traversal_Inft1(fp_out, pTree);// write in output file
                      fclose(fp_in);
                      fclose(fp_out);
                  }
                  else if (strcmp(option, "--avl") == 0) {

                      while (Check_file(fp_in) == 0) {
                            fscanf(fp_in, "%d;%f", &ID, &temp);
                            // insertAVLt1(pTree, ID, temp);
                            // prog avl ...
                      }
                      Traversal_Inft1(fp_out, pTree); // write in output file
                      fclose(fp_in);
                      fclose(fp_out);
                  }
                  else {
                      puts("incorrect option");
                      return ERROR_OPTIONS;
                  }
              }
              else{
                  puts("misinformed mode");
                  return ERROR_OPTIONS;
              }
          }
          else{
              puts("output file incorrectly entered");
              return ERROR_OPTIONS;
          }
      }

      else if(strcmp(input_filep1,"sortpressure.csv")==0) {

          if(strcmp(output_filep1, "sortpressure.txt")==0) {

              if(strcmp(mode, "-p1") == 0) {

                  if(strcmp(option,"--abr") == 0) {

                      while (Check_filep1(fp_inp1) == 0) {
                          fscanf(fp_inp1, "%d;%f", &ID, &press);
                          pTree = insertABRp1(pTree, ID, press);
                      }
                      Traversal_Infp1(fp_outp1, pTree);// write in output file
                      fclose(fp_inp1);
                      fclose(fp_outp1);
                  }
                  else if (strcmp(option, "--avl") == 0) {

                      while (Check_filep1(fp_inp1) == 0) {
                          fscanf(fp_inp1, "%d;%f", &ID, &press);
                          // insertAVLt1(pTree, ID, temp);
                          // prog avl ...
                      }
                      Traversal_Infp1(fp_outp1, pTree); // write in output file
                      fclose(fp_inp1);
                      fclose(fp_outp1);
                  }
                  else {
                      puts("incorrect option");
                      return ERROR_OPTIONS;
                  }
              }
              else{
                  puts("misinformed mode");
                  return ERROR_OPTIONS;
              }
          }
          else{
              puts("output file incorrectly entered");
              return ERROR_OPTIONS;
          }
      }

      else if(strcmp(input_fileh,"sortheight.csv")==0) {

          if(strcmp(output_fileh, "sortheight.txt")==0) {

              if(strcmp(mode, "-h") == 0) {

                  if(strcmp(option,"--abr") == 0) {

                      while (Check_fileh(fp_inh) == 0) {
                          fscanf(fp_inh, "%d;%d", &ID, &height);
                          pTree = insertABRh(pTree, ID, height);
                      }
                      Traversal_Infh(fp_outh, pTree);// write in output file
                      fclose(fp_inh);
                      fclose(fp_outh);
                  }
                  else if (strcmp(option, "--avl") == 0) {

                      while (Check_fileh(fp_inh) == 0) {
                          fscanf(fp_inh, "%d;%d", &ID, &height);
                          // insertAVLt1(pTree, ID, temp);
                          // prog avl ...
                      }
                      Traversal_Infh(fp_outh, pTree); // write in output file
                      fclose(fp_inh);
                      fclose(fp_outh);
                  }
                  else {
                      puts("incorrect option");
                      return ERROR_OPTIONS;
                  }
              }
              else{
                  puts("misinformed mode");
                  return ERROR_OPTIONS;
              }
          }
          else{
              puts("output file incorrectly entered");
              return ERROR_OPTIONS;
          }
      }

      else if(strcmp(input_filem,"sortmoisture.csv")==0) {

          if(strcmp(output_filem, "sortmoisture.txt")==0) {

              if(strcmp(mode, "-m") == 0) {

                  if(strcmp(option,"--abr") == 0) {

                      while (Check_filem(fp_inm) == 0) {
                          fscanf(fp_inm, "%d;%d", &ID, &moisture);
                          pTree = insertABRm(pTree, ID, moisture);
                      }
                      Traversal_Infm(fp_outm, pTree);// write in output file
                      fclose(fp_inm);
                      fclose(fp_outm);
                  }
                  else if (strcmp(option, "--avl") == 0) {

                      while (Check_filem(fp_inm) == 0) {
                          fscanf(fp_inm, "%d;%d", &ID, &moisture);
                          // insertAVLt1(pTree, ID, temp);
                          // prog avl ...
                      }
                      Traversal_Infm(fp_outm, pTree); //  write in output file
                      fclose(fp_inm);
                      fclose(fp_outm);
                  }
                  else {
                      puts("incorrect option");
                      return ERROR_OPTIONS;
                  }
              }
              else{
                  puts("misinformed mode");
                  return ERROR_OPTIONS;
              }
          }
          else{
              puts("output file incorrectly entered");
              return ERROR_OPTIONS;
          }
      }
      else {
          puts("input file incorrectly entered");
          return ERROR_OPTIONS;
      }
  }
  else{
      puts("misinformed arguments");
      return ERROR_OPTIONS;
  }

}
