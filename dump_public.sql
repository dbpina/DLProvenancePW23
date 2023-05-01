START TRANSACTION;
CREATE TABLE "public"."attribute" (
        "id"           INTEGER       NOT NULL DEFAULT next value for "public"."att_id_seq",
        "ds_id"        INTEGER       NOT NULL,
        "extractor_id" INTEGER,
        "name"         VARCHAR(30),
        "type"         VARCHAR(15),
        CONSTRAINT "attribute_id_pkey" PRIMARY KEY ("id"),
        CONSTRAINT "attribute_ds_id_fkey" FOREIGN KEY ("ds_id") REFERENCES "public"."data_set" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT "attribute_extractor_id_fkey" FOREIGN KEY ("extractor_id") REFERENCES "public"."extractor" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
COPY 75 RECORDS INTO "public"."attribute" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1       1       NULL    "dataset_path"  "TEXT"
2       1       NULL    "dataset_name"  "TEXT"
3       1       NULL    "description"   "TEXT"
4       2       NULL    "whatever"      "TEXT"
5       2       NULL    "whatever2"     "TEXT"
6       3       NULL    "optimizer_name"        "TEXT"
7       3       NULL    "learning_rate" "NUMERIC"
8       3       NULL    "num_epochs"    "NUMERIC"
9       3       NULL    "num_layers"    "NUMERIC"
10      4       NULL    "timestamp"     "TEXT"
11      4       NULL    "elapsed_time"  "TEXT"
12      4       NULL    "loss"  "NUMERIC"
13      4       NULL    "accuracy"      "NUMERIC"
14      4       NULL    "val_loss"      "NUMERIC"
15      4       NULL    "val_accuracy"  "NUMERIC"
16      4       NULL    "epoch" "NUMERIC"
17      5       NULL    "epochs_drop"   "NUMERIC"
18      5       NULL    "drop_n"        "NUMERIC"
19      5       NULL    "initial_lrate" "NUMERIC"
20      6       NULL    "new_lrate"     "NUMERIC"
21      6       NULL    "timestamp"     "TEXT"
22      6       NULL    "epoch_id"      "NUMERIC"
23      6       NULL    "adaptation_id" "NUMERIC"
24      7       NULL    "loss"  "NUMERIC"
25      7       NULL    "accuracy"      "NUMERIC"
26      8       NULL    "dataset_path"  "TEXT"
27      8       NULL    "dataset_name"  "TEXT"
28      8       NULL    "description"   "TEXT"
29      9       NULL    "whatever"      "TEXT"
30      9       NULL    "whatever2"     "TEXT"
31      10      NULL    "optimizer_name"        "TEXT"
32      10      NULL    "learning_rate" "NUMERIC"
33      10      NULL    "num_epochs"    "NUMERIC"
34      10      NULL    "num_layers"    "NUMERIC"
35      11      NULL    "timestamp"     "TEXT"
36      11      NULL    "elapsed_time"  "TEXT"
37      11      NULL    "loss"  "NUMERIC"
38      11      NULL    "accuracy"      "NUMERIC"
39      11      NULL    "val_loss"      "NUMERIC"
40      11      NULL    "val_accuracy"  "NUMERIC"
41      11      NULL    "epoch" "NUMERIC"
42      12      NULL    "epochs_drop"   "NUMERIC"
43      12      NULL    "drop_n"        "NUMERIC"
44      12      NULL    "initial_lrate" "NUMERIC"
45      13      NULL    "new_lrate"     "NUMERIC"
46      13      NULL    "timestamp"     "TEXT"
47      13      NULL    "epoch_id"      "NUMERIC"
48      13      NULL    "adaptation_id" "NUMERIC"
49      14      NULL    "loss"  "NUMERIC"
50      14      NULL    "accuracy"      "NUMERIC"
51      15      NULL    "dataset_path"  "TEXT"
52      15      NULL    "dataset_name"  "TEXT"
53      15      NULL    "description"   "TEXT"
54      16      NULL    "whatever"      "TEXT"
55      16      NULL    "whatever2"     "TEXT"
56      17      NULL    "optimizer_name"        "TEXT"
57      17      NULL    "learning_rate" "NUMERIC"
58      17      NULL    "num_epochs"    "NUMERIC"
59      17      NULL    "num_layers"    "NUMERIC"
60      18      NULL    "timestamp"     "TEXT"
61      18      NULL    "elapsed_time"  "TEXT"
62      18      NULL    "loss"  "NUMERIC"
63      18      NULL    "accuracy"      "NUMERIC"
64      18      NULL    "val_loss"      "NUMERIC"
65      18      NULL    "val_accuracy"  "NUMERIC"
66      18      NULL    "epoch" "NUMERIC"
67      19      NULL    "epochs_drop"   "NUMERIC"
68      19      NULL    "drop_n"        "NUMERIC"
69      19      NULL    "initial_lrate" "NUMERIC"
70      20      NULL    "new_lrate"     "NUMERIC"
71      20      NULL    "timestamp"     "TEXT"
72      20      NULL    "epoch_id"      "NUMERIC"
73      20      NULL    "adaptation_id" "NUMERIC"
74      21      NULL    "loss"  "NUMERIC"
75      21      NULL    "accuracy"      "NUMERIC"

CREATE TABLE "public"."dataflow" (
        "id"  INTEGER       NOT NULL DEFAULT next value for "public"."df_id_seq",
        "tag" VARCHAR(50)   NOT NULL,
        CONSTRAINT "dataflow_id_pkey" PRIMARY KEY ("id")
);
COPY 3 RECORDS INTO "public"."dataflow" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1       "framingham"
2       "fraud"
3       "census"

CREATE TABLE "public"."dataflow_execution" (
        "id"    INTEGER       NOT NULL DEFAULT next value for "public"."exec_id_seq",
        "tag"   VARCHAR(50)   NOT NULL,
        "df_id" INTEGER       NOT NULL,
        CONSTRAINT "dataflow_execution_tag_pkey" PRIMARY KEY ("tag"),
        CONSTRAINT "dataflow_execution_df_id_fkey" FOREIGN KEY ("df_id") REFERENCES "public"."dataflow" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
COPY 41 RECORDS INTO "public"."dataflow_execution" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1       "framingham-2023-02-03 12:00:10.485002" 1
2       "framingham-2023-02-03 12:00:42.062084" 1
3       "framingham-2023-02-03 12:01:34.267946" 1
4       "framingham-2023-02-03 12:04:43.870091" 1
5       "framingham-2023-02-03 12:05:32.841956" 1
6       "framingham-2023-02-03 12:06:18.464562" 1
7       "framingham-2023-02-03 12:07:59.794028" 1
8       "framingham-2023-02-03 12:09:52.051244" 1
9       "framingham-2023-02-03 12:11:19.176798" 1
10      "framingham-2023-02-03 12:12:11.355193" 1
11      "framingham-2023-02-03 12:14:27.741581" 1
12      "framingham-2023-02-03 12:16:37.236078" 1
13      "framingham-2023-02-03 12:18:51.412562" 1
14      "framingham-2023-02-03 12:21:10.085381" 1
15      "framingham-2023-02-03 12:23:21.249161" 1
16      "framingham-2023-02-03 12:26:45.528482" 1
17      "framingham-2023-02-03 12:29:09.914665" 1
18      "framingham-2023-02-03 12:31:28.581631" 1
19      "framingham-2023-02-03 12:32:35.903097" 1
20      "fraud-2023-02-03 12:43:19.958703"      2
21      "fraud-2023-02-03 12:44:04.120171"      2
22      "fraud-2023-02-03 12:44:46.477730"      2
23      "fraud-2023-02-03 12:51:50.227353"      2
24      "fraud-2023-02-03 12:58:28.523355"      2
25      "fraud-2023-02-03 13:05:15.623122"      2
26      "fraud-2023-02-03 13:19:53.398819"      2
27      "fraud-2023-02-03 13:32:55.326776"      2
28      "fraud-2023-02-03 14:09:14.604709"      2
29      "fraud-2023-02-03 14:35:21.138309"      2
30      "census-2023-02-03 14:56:35.602191"     3
31      "census-2023-02-03 14:59:53.041733"     3
32      "census-2023-02-03 15:03:44.122674"     3
33      "census-2023-02-03 15:11:34.999357"     3
34      "census-2023-02-03 15:17:53.484860"     3
35      "census-2023-02-03 15:21:13.035755"     3
36      "census-2023-02-03 15:29:13.185337"     3
37      "census-2023-02-03 15:35:52.398132"     3
38      "census-2023-02-03 15:46:12.189995"     3
39      "census-2023-02-03 15:50:05.139331"     3
40      "census-2023-02-03 16:01:09.872749"     3
41      "census-2023-02-03 16:20:34.451890"     3

CREATE TABLE "public"."task" (
        "id"                 INTEGER       NOT NULL DEFAULT next value for "public"."task_id_seq",
        "identifier"         INTEGER       NOT NULL,
        "df_version"         INTEGER       NOT NULL,
        "df_exec"            VARCHAR(50)   NOT NULL,
        "dt_id"              INTEGER       NOT NULL,
        "status"             VARCHAR(10),
        "workspace"          VARCHAR(500),
        "computing_resource" VARCHAR(100),
        "output_msg"         CHARACTER LARGE OBJECT,
        "error_msg"          CHARACTER LARGE OBJECT,
        CONSTRAINT "task_id_pkey" PRIMARY KEY ("id"),
        CONSTRAINT "task_df_exec_fkey" FOREIGN KEY ("df_exec") REFERENCES "public"."dataflow_execution" ("tag") ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT "task_df_version_fkey" FOREIGN KEY ("df_version") REFERENCES "public"."dataflow_version" ("version") ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT "task_dt_id_fkey" FOREIGN KEY ("dt_id") REFERENCES "public"."data_transformation" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
COPY 119 RECORDS INTO "public"."task" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1       1       1       "framingham-2023-02-03 12:00:10.485002" 1       "FINISHED"      "null"  "null"  "null"  "null"
2       2       1       "framingham-2023-02-03 12:00:10.485002" 2       "FINISHED"      "null"  "null"  "null"  "null"
3       3       1       "framingham-2023-02-03 12:00:10.485002" 4       "FINISHED"      "null"  "null"  "null"  "null"
4       1       1       "framingham-2023-02-03 12:00:42.062084" 1       "FINISHED"      "null"  "null"  "null"  "null"
5       2       1       "framingham-2023-02-03 12:00:42.062084" 2       "FINISHED"      "null"  "null"  "null"  "null"
6       3       1       "framingham-2023-02-03 12:00:42.062084" 4       "FINISHED"      "null"  "null"  "null"  "null"
7       1       1       "framingham-2023-02-03 12:01:34.267946" 1       "FINISHED"      "null"  "null"  "null"  "null"
8       2       1       "framingham-2023-02-03 12:01:34.267946" 2       "FINISHED"      "null"  "null"  "null"  "null"
9       3       1       "framingham-2023-02-03 12:01:34.267946" 4       "FINISHED"      "null"  "null"  "null"  "null"
10      1       1       "framingham-2023-02-03 12:04:43.870091" 1       "FINISHED"      "null"  "null"  "null"  "null"
11      2       1       "framingham-2023-02-03 12:04:43.870091" 2       "FINISHED"      "null"  "null"  "null"  "null"
12      3       1       "framingham-2023-02-03 12:04:43.870091" 4       "FINISHED"      "null"  "null"  "null"  "null"
13      1       1       "framingham-2023-02-03 12:05:32.841956" 1       "FINISHED"      "null"  "null"  "null"  "null"
14      2       1       "framingham-2023-02-03 12:05:32.841956" 2       "FINISHED"      "null"  "null"  "null"  "null"
15      3       1       "framingham-2023-02-03 12:05:32.841956" 4       "FINISHED"      "null"  "null"  "null"  "null"
16      1       1       "framingham-2023-02-03 12:06:18.464562" 1       "FINISHED"      "null"  "null"  "null"  "null"
17      2       1       "framingham-2023-02-03 12:06:18.464562" 2       "FINISHED"      "null"  "null"  "null"  "null"
18      3       1       "framingham-2023-02-03 12:06:18.464562" 4       "FINISHED"      "null"  "null"  "null"  "null"
19      1       1       "framingham-2023-02-03 12:07:59.794028" 1       "FINISHED"      "null"  "null"  "null"  "null"
20      2       1       "framingham-2023-02-03 12:07:59.794028" 2       "FINISHED"      "null"  "null"  "null"  "null"
21      3       1       "framingham-2023-02-03 12:07:59.794028" 4       "FINISHED"      "null"  "null"  "null"  "null"
22      1       1       "framingham-2023-02-03 12:09:52.051244" 1       "FINISHED"      "null"  "null"  "null"  "null"
23      2       1       "framingham-2023-02-03 12:09:52.051244" 2       "FINISHED"      "null"  "null"  "null"  "null"
24      3       1       "framingham-2023-02-03 12:09:52.051244" 4       "FINISHED"      "null"  "null"  "null"  "null"
25      1       1       "framingham-2023-02-03 12:11:19.176798" 1       "FINISHED"      "null"  "null"  "null"  "null"
26      2       1       "framingham-2023-02-03 12:11:19.176798" 2       "FINISHED"      "null"  "null"  "null"  "null"
27      3       1       "framingham-2023-02-03 12:11:19.176798" 4       "FINISHED"      "null"  "null"  "null"  "null"
28      1       1       "framingham-2023-02-03 12:12:11.355193" 1       "FINISHED"      "null"  "null"  "null"  "null"
29      2       1       "framingham-2023-02-03 12:12:11.355193" 2       "FINISHED"      "null"  "null"  "null"  "null"
30      3       1       "framingham-2023-02-03 12:12:11.355193" 4       "FINISHED"      "null"  "null"  "null"  "null"
31      1       1       "framingham-2023-02-03 12:14:27.741581" 1       "FINISHED"      "null"  "null"  "null"  "null"
32      2       1       "framingham-2023-02-03 12:14:27.741581" 2       "FINISHED"      "null"  "null"  "null"  "null"
33      3       1       "framingham-2023-02-03 12:14:27.741581" 4       "FINISHED"      "null"  "null"  "null"  "null"
34      1       1       "framingham-2023-02-03 12:16:37.236078" 1       "FINISHED"      "null"  "null"  "null"  "null"
35      2       1       "framingham-2023-02-03 12:16:37.236078" 2       "FINISHED"      "null"  "null"  "null"  "null"
36      3       1       "framingham-2023-02-03 12:16:37.236078" 4       "FINISHED"      "null"  "null"  "null"  "null"
37      1       1       "framingham-2023-02-03 12:18:51.412562" 1       "FINISHED"      "null"  "null"  "null"  "null"
38      2       1       "framingham-2023-02-03 12:18:51.412562" 2       "FINISHED"      "null"  "null"  "null"  "null"
39      3       1       "framingham-2023-02-03 12:18:51.412562" 4       "FINISHED"      "null"  "null"  "null"  "null"
40      1       1       "framingham-2023-02-03 12:21:10.085381" 1       "FINISHED"      "null"  "null"  "null"  "null"
41      2       1       "framingham-2023-02-03 12:21:10.085381" 2       "FINISHED"      "null"  "null"  "null"  "null"
42      3       1       "framingham-2023-02-03 12:21:10.085381" 4       "FINISHED"      "null"  "null"  "null"  "null"
43      1       1       "framingham-2023-02-03 12:23:21.249161" 1       "FINISHED"      "null"  "null"  "null"  "null"
44      2       1       "framingham-2023-02-03 12:23:21.249161" 2       "FINISHED"      "null"  "null"  "null"  "null"
45      3       1       "framingham-2023-02-03 12:23:21.249161" 4       "FINISHED"      "null"  "null"  "null"  "null"
46      1       1       "framingham-2023-02-03 12:26:45.528482" 1       "FINISHED"      "null"  "null"  "null"  "null"
47      2       1       "framingham-2023-02-03 12:26:45.528482" 2       "FINISHED"      "null"  "null"  "null"  "null"
48      3       1       "framingham-2023-02-03 12:26:45.528482" 4       "FINISHED"      "null"  "null"  "null"  "null"
49      1       1       "framingham-2023-02-03 12:29:09.914665" 1       "FINISHED"      "null"  "null"  "null"  "null"
50      2       1       "framingham-2023-02-03 12:29:09.914665" 2       "FINISHED"      "null"  "null"  "null"  "null"
51      3       1       "framingham-2023-02-03 12:29:09.914665" 4       "FINISHED"      "null"  "null"  "null"  "null"
52      1       1       "framingham-2023-02-03 12:31:28.581631" 1       "FINISHED"      "null"  "null"  "null"  "null"
53      2       1       "framingham-2023-02-03 12:31:28.581631" 2       "FINISHED"      "null"  "null"  "null"  "null"
54      3       1       "framingham-2023-02-03 12:31:28.581631" 4       "FINISHED"      "null"  "null"  "null"  "null"
55      1       1       "framingham-2023-02-03 12:32:35.903097" 1       "FINISHED"      "null"  "null"  "null"  "null"
56      2       1       "framingham-2023-02-03 12:32:35.903097" 2       "FINISHED"      "null"  "null"  "null"  "null"
57      3       1       "framingham-2023-02-03 12:32:35.903097" 4       "FINISHED"      "null"  "null"  "null"  "null"
58      1       2       "fraud-2023-02-03 12:43:19.958703"      5       "RUNNING"       "null"  "null"  "null"  "null"
59      1       2       "fraud-2023-02-03 12:44:04.120171"      5       "FINISHED"      "null"  "null"  "null"  "null"
60      1       2       "fraud-2023-02-03 12:44:46.477730"      5       "FINISHED"      "null"  "null"  "null"  "null"
61      2       2       "fraud-2023-02-03 12:44:46.477730"      6       "FINISHED"      "null"  "null"  "null"  "null"
62      3       2       "fraud-2023-02-03 12:44:46.477730"      8       "FINISHED"      "null"  "null"  "null"  "null"
63      1       2       "fraud-2023-02-03 12:51:50.227353"      5       "FINISHED"      "null"  "null"  "null"  "null"
64      2       2       "fraud-2023-02-03 12:51:50.227353"      6       "FINISHED"      "null"  "null"  "null"  "null"
65      3       2       "fraud-2023-02-03 12:51:50.227353"      8       "FINISHED"      "null"  "null"  "null"  "null"
66      1       2       "fraud-2023-02-03 12:58:28.523355"      5       "FINISHED"      "null"  "null"  "null"  "null"
67      2       2       "fraud-2023-02-03 12:58:28.523355"      6       "FINISHED"      "null"  "null"  "null"  "null"
68      3       2       "fraud-2023-02-03 12:58:28.523355"      8       "FINISHED"      "null"  "null"  "null"  "null"
69      1       2       "fraud-2023-02-03 13:05:15.623122"      5       "FINISHED"      "null"  "null"  "null"  "null"
70      2       2       "fraud-2023-02-03 13:05:15.623122"      6       "FINISHED"      "null"  "null"  "null"  "null"
71      3       2       "fraud-2023-02-03 13:05:15.623122"      8       "FINISHED"      "null"  "null"  "null"  "null"
72      1       2       "fraud-2023-02-03 13:19:53.398819"      5       "FINISHED"      "null"  "null"  "null"  "null"
73      2       2       "fraud-2023-02-03 13:19:53.398819"      6       "FINISHED"      "null"  "null"  "null"  "null"
74      3       2       "fraud-2023-02-03 13:19:53.398819"      8       "FINISHED"      "null"  "null"  "null"  "null"
75      1       2       "fraud-2023-02-03 13:32:55.326776"      5       "FINISHED"      "null"  "null"  "null"  "null"
76      2       2       "fraud-2023-02-03 13:32:55.326776"      6       "FINISHED"      "null"  "null"  "null"  "null"
77      3       2       "fraud-2023-02-03 13:32:55.326776"      8       "FINISHED"      "null"  "null"  "null"  "null"
78      1       2       "fraud-2023-02-03 14:09:14.604709"      5       "FINISHED"      "null"  "null"  "null"  "null"
79      2       2       "fraud-2023-02-03 14:09:14.604709"      6       "FINISHED"      "null"  "null"  "null"  "null"
80      3       2       "fraud-2023-02-03 14:09:14.604709"      8       "FINISHED"      "null"  "null"  "null"  "null"
81      1       2       "fraud-2023-02-03 14:35:21.138309"      5       "FINISHED"      "null"  "null"  "null"  "null"
82      2       2       "fraud-2023-02-03 14:35:21.138309"      6       "FINISHED"      "null"  "null"  "null"  "null"
83      3       2       "fraud-2023-02-03 14:35:21.138309"      8       "FINISHED"      "null"  "null"  "null"  "null"
84      1       3       "census-2023-02-03 14:56:35.602191"     9       "FINISHED"      "null"  "null"  "null"  "null"
85      2       3       "census-2023-02-03 14:56:35.602191"     10      "FINISHED"      "null"  "null"  "null"  "null"
86      3       3       "census-2023-02-03 14:56:35.602191"     12      "FINISHED"      "null"  "null"  "null"  "null"
87      1       3       "census-2023-02-03 14:59:53.041733"     9       "FINISHED"      "null"  "null"  "null"  "null"
88      2       3       "census-2023-02-03 14:59:53.041733"     10      "FINISHED"      "null"  "null"  "null"  "null"
89      3       3       "census-2023-02-03 14:59:53.041733"     12      "FINISHED"      "null"  "null"  "null"  "null"
90      1       3       "census-2023-02-03 15:03:44.122674"     9       "FINISHED"      "null"  "null"  "null"  "null"
91      2       3       "census-2023-02-03 15:03:44.122674"     10      "FINISHED"      "null"  "null"  "null"  "null"
92      3       3       "census-2023-02-03 15:03:44.122674"     12      "FINISHED"      "null"  "null"  "null"  "null"
93      1       3       "census-2023-02-03 15:11:34.999357"     9       "FINISHED"      "null"  "null"  "null"  "null"
94      2       3       "census-2023-02-03 15:11:34.999357"     10      "FINISHED"      "null"  "null"  "null"  "null"
95      3       3       "census-2023-02-03 15:11:34.999357"     12      "FINISHED"      "null"  "null"  "null"  "null"
96      1       3       "census-2023-02-03 15:17:53.484860"     9       "FINISHED"      "null"  "null"  "null"  "null"
97      2       3       "census-2023-02-03 15:17:53.484860"     10      "FINISHED"      "null"  "null"  "null"  "null"
98      3       3       "census-2023-02-03 15:17:53.484860"     12      "FINISHED"      "null"  "null"  "null"  "null"
99      1       3       "census-2023-02-03 15:21:13.035755"     9       "FINISHED"      "null"  "null"  "null"  "null"
100     2       3       "census-2023-02-03 15:21:13.035755"     10      "FINISHED"      "null"  "null"  "null"  "null"
101     3       3       "census-2023-02-03 15:21:13.035755"     12      "FINISHED"      "null"  "null"  "null"  "null"
102     1       3       "census-2023-02-03 15:29:13.185337"     9       "FINISHED"      "null"  "null"  "null"  "null"
103     2       3       "census-2023-02-03 15:29:13.185337"     10      "FINISHED"      "null"  "null"  "null"  "null"
104     3       3       "census-2023-02-03 15:29:13.185337"     12      "FINISHED"      "null"  "null"  "null"  "null"
105     1       3       "census-2023-02-03 15:35:52.398132"     9       "FINISHED"      "null"  "null"  "null"  "null"
106     2       3       "census-2023-02-03 15:35:52.398132"     10      "FINISHED"      "null"  "null"  "null"  "null"
107     3       3       "census-2023-02-03 15:35:52.398132"     12      "FINISHED"      "null"  "null"  "null"  "null"
108     1       3       "census-2023-02-03 15:46:12.189995"     9       "FINISHED"      "null"  "null"  "null"  "null"
109     2       3       "census-2023-02-03 15:46:12.189995"     10      "FINISHED"      "null"  "null"  "null"  "null"
110     3       3       "census-2023-02-03 15:46:12.189995"     12      "FINISHED"      "null"  "null"  "null"  "null"
111     1       3       "census-2023-02-03 15:50:05.139331"     9       "FINISHED"      "null"  "null"  "null"  "null"
112     2       3       "census-2023-02-03 15:50:05.139331"     10      "FINISHED"      "null"  "null"  "null"  "null"
113     3       3       "census-2023-02-03 15:50:05.139331"     12      "FINISHED"      "null"  "null"  "null"  "null"
114     1       3       "census-2023-02-03 16:01:09.872749"     9       "FINISHED"      "null"  "null"  "null"  "null"
115     2       3       "census-2023-02-03 16:01:09.872749"     10      "FINISHED"      "null"  "null"  "null"  "null"
116     3       3       "census-2023-02-03 16:01:09.872749"     12      "FINISHED"      "null"  "null"  "null"  "null"
117     1       3       "census-2023-02-03 16:20:34.451890"     9       "FINISHED"      "null"  "null"  "null"  "null"
118     2       3       "census-2023-02-03 16:20:34.451890"     10      "FINISHED"      "null"  "null"  "null"  "null"
119     3       3       "census-2023-02-03 16:20:34.451890"     12      "FINISHED"      "null"  "null"  "null"  "null"


CREATE TABLE "public"."performance" (
        "id"          INTEGER       NOT NULL DEFAULT next value for "public"."performance_id_seq",
        "task_id"     INTEGER       NOT NULL,
        "subtask_id"  INTEGER,
        "method"      VARCHAR(30)   NOT NULL,
        "description" VARCHAR(200),
        "starttime"   VARCHAR(30),
        "endtime"     VARCHAR(30),
        "invocation"  CHARACTER LARGE OBJECT,
        CONSTRAINT "performance_id_pkey" PRIMARY KEY ("id"),
        CONSTRAINT "performance_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "public"."task" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
COPY 118 RECORDS INTO "public"."performance" FROM stdin USING DELIMITERS E'\t',E'\n','"';
1       1       NULL    "null"  "null"  "2023-02-03 12:00:10"   "2023-02-03 12:00:10"   "null"
2       2       NULL    "null"  "null"  "2023-02-03 12:00:10"   "2023-02-03 12:00:12"   "null"
3       3       NULL    "null"  "null"  "2023-02-03 12:00:12"   "2023-02-03 12:00:12"   "null"
4       4       NULL    "null"  "null"  "2023-02-03 12:00:42"   "2023-02-03 12:00:42"   "null"
5       5       NULL    "null"  "null"  "2023-02-03 12:00:42"   "2023-02-03 12:01:07"   "null"
6       6       NULL    "null"  "null"  "2023-02-03 12:01:07"   "2023-02-03 12:01:08"   "null"
7       7       NULL    "null"  "null"  "2023-02-03 12:01:34"   "2023-02-03 12:01:34"   "null"
8       8       NULL    "null"  "null"  "2023-02-03 12:01:34"   "2023-02-03 12:02:00"   "null"
9       9       NULL    "null"  "null"  "2023-02-03 12:02:00"   "2023-02-03 12:02:00"   "null"
10      10      NULL    "null"  "null"  "2023-02-03 12:04:43"   "2023-02-03 12:04:43"   "null"
11      11      NULL    "null"  "null"  "2023-02-03 12:04:44"   "2023-02-03 12:05:10"   "null"
12      12      NULL    "null"  "null"  "2023-02-03 12:05:10"   "2023-02-03 12:05:10"   "null"
13      13      NULL    "null"  "null"  "2023-02-03 12:05:32"   "2023-02-03 12:05:32"   "null"
14      14      NULL    "null"  "null"  "2023-02-03 12:05:32"   "2023-02-03 12:05:59"   "null"
15      15      NULL    "null"  "null"  "2023-02-03 12:05:59"   "2023-02-03 12:05:59"   "null"
16      16      NULL    "null"  "null"  "2023-02-03 12:06:18"   "2023-02-03 12:06:18"   "null"
17      17      NULL    "null"  "null"  "2023-02-03 12:06:18"   "2023-02-03 12:06:44"   "null"
18      18      NULL    "null"  "null"  "2023-02-03 12:06:44"   "2023-02-03 12:06:44"   "null"
19      19      NULL    "null"  "null"  "2023-02-03 12:07:59"   "2023-02-03 12:07:59"   "null"
20      20      NULL    "null"  "null"  "2023-02-03 12:07:59"   "2023-02-03 12:08:26"   "null"
21      21      NULL    "null"  "null"  "2023-02-03 12:08:26"   "2023-02-03 12:08:27"   "null"
22      22      NULL    "null"  "null"  "2023-02-03 12:09:52"   "2023-02-03 12:09:52"   "null"
23      23      NULL    "null"  "null"  "2023-02-03 12:09:52"   "2023-02-03 12:10:18"   "null"
24      24      NULL    "null"  "null"  "2023-02-03 12:10:18"   "2023-02-03 12:10:18"   "null"
25      25      NULL    "null"  "null"  "2023-02-03 12:11:19"   "2023-02-03 12:11:19"   "null"
26      26      NULL    "null"  "null"  "2023-02-03 12:11:19"   "2023-02-03 12:11:52"   "null"
27      27      NULL    "null"  "null"  "2023-02-03 12:11:52"   "2023-02-03 12:11:53"   "null"
28      28      NULL    "null"  "null"  "2023-02-03 12:12:11"   "2023-02-03 12:12:11"   "null"
29      29      NULL    "null"  "null"  "2023-02-03 12:12:11"   "2023-02-03 12:12:41"   "null"
30      30      NULL    "null"  "null"  "2023-02-03 12:12:41"   "2023-02-03 12:12:41"   "null"
31      31      NULL    "null"  "null"  "2023-02-03 12:14:27"   "2023-02-03 12:14:27"   "null"
32      32      NULL    "null"  "null"  "2023-02-03 12:14:27"   "2023-02-03 12:14:54"   "null"
33      33      NULL    "null"  "null"  "2023-02-03 12:14:54"   "2023-02-03 12:14:54"   "null"
34      34      NULL    "null"  "null"  "2023-02-03 12:16:37"   "2023-02-03 12:16:37"   "null"
35      35      NULL    "null"  "null"  "2023-02-03 12:16:37"   "2023-02-03 12:17:31"   "null"
36      36      NULL    "null"  "null"  "2023-02-03 12:17:31"   "2023-02-03 12:17:31"   "null"
37      37      NULL    "null"  "null"  "2023-02-03 12:18:51"   "2023-02-03 12:18:51"   "null"
38      38      NULL    "null"  "null"  "2023-02-03 12:18:51"   "2023-02-03 12:19:43"   "null"
39      39      NULL    "null"  "null"  "2023-02-03 12:19:43"   "2023-02-03 12:19:43"   "null"
40      40      NULL    "null"  "null"  "2023-02-03 12:21:10"   "2023-02-03 12:21:10"   "null"
41      41      NULL    "null"  "null"  "2023-02-03 12:21:10"   "2023-02-03 12:22:06"   "null"
42      42      NULL    "null"  "null"  "2023-02-03 12:22:06"   "2023-02-03 12:22:06"   "null"
43      43      NULL    "null"  "null"  "2023-02-03 12:23:21"   "2023-02-03 12:23:21"   "null"
44      44      NULL    "null"  "null"  "2023-02-03 12:23:21"   "2023-02-03 12:24:20"   "null"
45      45      NULL    "null"  "null"  "2023-02-03 12:24:20"   "2023-02-03 12:24:20"   "null"
46      46      NULL    "null"  "null"  "2023-02-03 12:26:45"   "2023-02-03 12:26:45"   "null"
47      47      NULL    "null"  "null"  "2023-02-03 12:26:45"   "2023-02-03 12:27:37"   "null"
48      48      NULL    "null"  "null"  "2023-02-03 12:27:37"   "2023-02-03 12:27:37"   "null"
49      49      NULL    "null"  "null"  "2023-02-03 12:29:09"   "2023-02-03 12:29:09"   "null"
50      50      NULL    "null"  "null"  "2023-02-03 12:29:10"   "2023-02-03 12:29:57"   "null"
51      51      NULL    "null"  "null"  "2023-02-03 12:29:57"   "2023-02-03 12:29:57"   "null"
52      52      NULL    "null"  "null"  "2023-02-03 12:31:28"   "2023-02-03 12:31:28"   "null"
53      53      NULL    "null"  "null"  "2023-02-03 12:31:28"   "2023-02-03 12:32:18"   "null"
54      54      NULL    "null"  "null"  "2023-02-03 12:32:18"   "2023-02-03 12:32:18"   "null"
55      55      NULL    "null"  "null"  "2023-02-03 12:32:35"   "2023-02-03 12:32:35"   "null"
56      56      NULL    "null"  "null"  "2023-02-03 12:32:36"   "2023-02-03 12:33:24"   "null"
57      57      NULL    "null"  "null"  "2023-02-03 12:33:24"   "2023-02-03 12:33:24"   "null"
58      59      NULL    "null"  "null"  "2023-02-03 12:44:04"   "2023-02-03 12:44:04"   "null"
59      60      NULL    "null"  "null"  "2023-02-03 12:44:46"   "2023-02-03 12:44:46"   "null"
60      61      NULL    "null"  "null"  "2023-02-03 12:44:46"   "2023-02-03 12:44:50"   "null"
61      62      NULL    "null"  "null"  "2023-02-03 12:44:50"   "2023-02-03 12:44:50"   "null"
62      63      NULL    "null"  "null"  "2023-02-03 12:51:50"   "2023-02-03 12:51:55"   "null"
63      64      NULL    "null"  "null"  "2023-02-03 12:51:55"   "2023-02-03 12:52:53"   "null"
64      65      NULL    "null"  "null"  "2023-02-03 12:52:53"   "2023-02-03 12:52:55"   "null"
65      66      NULL    "null"  "null"  "2023-02-03 12:58:28"   "2023-02-03 12:58:31"   "null"
66      67      NULL    "null"  "null"  "2023-02-03 12:58:31"   "2023-02-03 13:04:54"   "null"
67      68      NULL    "null"  "null"  "2023-02-03 13:04:54"   "2023-02-03 13:04:55"   "null"
68      69      NULL    "null"  "null"  "2023-02-03 13:05:15"   "2023-02-03 13:05:19"   "null"
69      70      NULL    "null"  "null"  "2023-02-03 13:05:19"   "2023-02-03 13:11:46"   "null"
70      71      NULL    "null"  "null"  "2023-02-03 13:11:46"   "2023-02-03 13:11:47"   "null"
71      72      NULL    "null"  "null"  "2023-02-03 13:19:53"   "2023-02-03 13:19:56"   "null"
72      73      NULL    "null"  "null"  "2023-02-03 13:19:57"   "2023-02-03 13:26:20"   "null"
73      74      NULL    "null"  "null"  "2023-02-03 13:26:20"   "2023-02-03 13:26:21"   "null"
74      75      NULL    "null"  "null"  "2023-02-03 13:32:55"   "2023-02-03 13:32:58"   "null"
75      76      NULL    "null"  "null"  "2023-02-03 13:32:58"   "2023-02-03 13:39:20"   "null"
76      77      NULL    "null"  "null"  "2023-02-03 13:39:20"   "2023-02-03 13:39:20"   "null"
77      78      NULL    "null"  "null"  "2023-02-03 14:09:14"   "2023-02-03 14:09:17"   "null"
78      79      NULL    "null"  "null"  "2023-02-03 14:09:17"   "2023-02-03 14:15:34"   "null"
79      80      NULL    "null"  "null"  "2023-02-03 14:15:34"   "2023-02-03 14:15:35"   "null"
80      81      NULL    "null"  "null"  "2023-02-03 14:35:21"   "2023-02-03 14:35:24"   "null"
81      82      NULL    "null"  "null"  "2023-02-03 14:35:24"   "2023-02-03 14:46:59"   "null"
82      83      NULL    "null"  "null"  "2023-02-03 14:46:59"   "2023-02-03 14:47:00"   "null"
83      84      NULL    "null"  "null"  "2023-02-03 14:56:35"   "2023-02-03 14:56:35"   "null"
84      85      NULL    "null"  "null"  "2023-02-03 14:56:35"   "2023-02-03 14:56:37"   "null"
85      86      NULL    "null"  "null"  "2023-02-03 14:56:37"   "2023-02-03 14:56:37"   "null"
86      87      NULL    "null"  "null"  "2023-02-03 14:59:53"   "2023-02-03 14:59:54"   "null"
87      88      NULL    "null"  "null"  "2023-02-03 14:59:54"   "2023-02-03 15:02:37"   "null"
88      89      NULL    "null"  "null"  "2023-02-03 15:02:37"   "2023-02-03 15:02:38"   "null"
89      90      NULL    "null"  "null"  "2023-02-03 15:03:44"   "2023-02-03 15:03:45"   "null"
90      91      NULL    "null"  "null"  "2023-02-03 15:03:45"   "2023-02-03 15:06:41"   "null"
91      92      NULL    "null"  "null"  "2023-02-03 15:06:41"   "2023-02-03 15:06:42"   "null"
92      93      NULL    "null"  "null"  "2023-02-03 15:11:34"   "2023-02-03 15:11:36"   "null"
93      94      NULL    "null"  "null"  "2023-02-03 15:11:36"   "2023-02-03 15:14:31"   "null"
94      95      NULL    "null"  "null"  "2023-02-03 15:14:31"   "2023-02-03 15:14:31"   "null"
95      96      NULL    "null"  "null"  "2023-02-03 15:17:53"   "2023-02-03 15:17:54"   "null"
96      97      NULL    "null"  "null"  "2023-02-03 15:17:54"   "2023-02-03 15:20:53"   "null"
97      98      NULL    "null"  "null"  "2023-02-03 15:20:53"   "2023-02-03 15:20:53"   "null"
98      99      NULL    "null"  "null"  "2023-02-03 15:21:13"   "2023-02-03 15:21:14"   "null"
99      100     NULL    "null"  "null"  "2023-02-03 15:21:14"   "2023-02-03 15:24:13"   "null"
100     101     NULL    "null"  "null"  "2023-02-03 15:24:13"   "2023-02-03 15:24:14"   "null"
101     102     NULL    "null"  "null"  "2023-02-03 15:29:13"   "2023-02-03 15:29:14"   "null"
102     103     NULL    "null"  "null"  "2023-02-03 15:29:14"   "2023-02-03 15:32:16"   "null"
103     104     NULL    "null"  "null"  "2023-02-03 15:32:16"   "2023-02-03 15:32:17"   "null"
104     105     NULL    "null"  "null"  "2023-02-03 15:35:52"   "2023-02-03 15:35:53"   "null"
105     106     NULL    "null"  "null"  "2023-02-03 15:35:53"   "2023-02-03 15:38:52"   "null"
106     107     NULL    "null"  "null"  "2023-02-03 15:38:52"   "2023-02-03 15:38:52"   "null"
107     108     NULL    "null"  "null"  "2023-02-03 15:46:12"   "2023-02-03 15:46:13"   "null"
108     109     NULL    "null"  "null"  "2023-02-03 15:46:13"   "2023-02-03 15:49:11"   "null"
109     110     NULL    "null"  "null"  "2023-02-03 15:49:12"   "2023-02-03 15:49:12"   "null"
110     111     NULL    "null"  "null"  "2023-02-03 15:50:05"   "2023-02-03 15:50:05"   "null"
111     112     NULL    "null"  "null"  "2023-02-03 15:50:06"   "2023-02-03 15:55:23"   "null"
112     113     NULL    "null"  "null"  "2023-02-03 15:55:23"   "2023-02-03 15:55:24"   "null"
113     114     NULL    "null"  "null"  "2023-02-03 16:01:09"   "2023-02-03 16:01:10"   "null"
114     115     NULL    "null"  "null"  "2023-02-03 16:01:10"   "2023-02-03 16:06:29"   "null"
115     116     NULL    "null"  "null"  "2023-02-03 16:06:29"   "2023-02-03 16:06:29"   "null"
116     117     NULL    "null"  "null"  "2023-02-03 16:20:34"   "2023-02-03 16:20:35"   "null"
117     118     NULL    "null"  "null"  "2023-02-03 16:20:35"   "2023-02-03 16:28:12"   "null"
118     119     NULL    "null"  "null"  "2023-02-03 16:28:12"   "2023-02-03 16:28:12"   "null"



