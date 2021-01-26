<template>
  <v-row justify="center" align="center">

    <!-- ランキング表示カラム -->
    <v-col cols="12" sm="8" md="4" align="start">
      <v-card>
        <!-- カードテキスト -->
        <v-card-text>
          <v-row align="center" justify="center">
            <v-col cols="12" sm="8" md="8">
              チャンネルを選択
            </v-col>

            <v-col cols="12" sm="4" md="4" align="center">
              <v-dialog
                v-model="dialog"
                scrollable
                max-width="300px"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    color="primary"
                    dark
                    v-bind="attrs"
                    v-on="on"
                  >
                    追加
                  </v-btn>
                </template>

                <v-card>
                  <v-card-title>チャンネルを選択</v-card-title>
                  <v-divider></v-divider>
                  <v-card-text style="height: 300px;">
                    <v-radio-group
                      v-model="dialogm1"
                      column
                    >
                      <v-radio
                        label="general"
                        value="general"
                      ></v-radio>
                      <v-radio
                        label="tandom"
                        value="random"
                      ></v-radio>
                      <v-radio
                        label="agenda"
                        value="agenda"
                      ></v-radio>
                      <v-radio
                        label="times"
                        value="times"
                      ></v-radio>
                    </v-radio-group>
                  </v-card-text>
                  <v-divider></v-divider>
                  <v-card-actions>
                    <v-btn
                      color="blue darken-1"
                      text
                      @click="dialog = false"
                    >
                      Close
                    </v-btn>
                    <v-btn
                      color="blue darken-1"
                      text
                      @click="dialog = false"
                    >
                      Save
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </v-col>
          </v-row>
      
          <v-spacer></v-spacer>

          <v-chip
            v-for="chip in showActiveChannels"
            :key="chip.name"
            class="ma-2"
            close
            label
            @click:close="chip.active = false"
          >
            {{chip.name}}
          </v-chip>
          
          </v-card-text>

          <v-divider></v-divider>

          <v-card-text>
            <p>期間を選択</p>
            <v-menu
              ref="menu"
              v-model="menu"
              :close-on-content-click="false"
              transition="scale-transition"
              offset-y
              min-width="auto"
            >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
              v-model="dateRangeText"
              label="Date range"
              prepend-icon="mdi-calendar"
              readonly
              v-bind="attrs"
              v-on="on"
            />
            </template>

            <v-date-picker
              ref="picker"
              v-model="dates"
              range
              @change="save"
            ></v-date-picker>
            </v-menu>
          </v-card-text>

          <!-- ランキング表示 -->
          <v-list subheader two-line>

          <v-list-item v-for="folder in folders" :key="folder.title">
          <v-list-item-avatar>
            <v-icon class="grey lighten-1" dark >
              mdi-numeric-1-box
            </v-icon>
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title v-text="folder.title"></v-list-item-title>

            <v-list-item-subtitle v-text="folder.subtitle"></v-list-item-subtitle>
          </v-list-item-content>
          
        </v-list-item>

        <v-divider></v-divider>
      </v-list>

      <!-- v-btnやv-menuなどのカードのactionsを配置するためのコンテナ -->
      <v-card-actions>
        <v-spacer />
        <v-btn color="primary" nuxt to="/messages"> Search Messages </v-btn>
      </v-card-actions>
    </v-card>
  </v-col>

    <!-- グラフ表示 -->
    <v-col cols="12" sm="8" md="8" align="start">
      <!-- カード領域 -->
      <v-card>
        
        <v-card-text>
          <v-row>
            <v-col cols="6" sm="6" md="6">
              各単語の流行グラフ
            </v-col>
            <v-col cols="6" sm="6" md="6" align="end">
              過去1ヶ月
            </v-col>
          </v-row>
        </v-card-text>

        <v-card-text>
          <v-icon color="graph-dot" >
            mdi-numeric-1-box-outline
          </v-icon> スライドレビュー

          <!-- 流行グラフ -->
          <v-sparkline
            :labels="labels"
            :value="value"
            color="graph"
            line-width="1"
            padding="10"
            :smooth="10"
            fill
            width="500"
          ></v-sparkline>

        </v-card-text>
        
      </v-card>
    </v-col>

    <!-- <v-col cols="12" sm="8" md="8" align="start">
      <v-card>
        
        <v-card-text>
          <img width="75%" height="75%" src="@/assets/index.png">
        </v-card-text>
        
      </v-card>
    </v-col> -->

  </v-row>
</template>

<script>
import Logo from '~/components/Logo.vue'
import VuetifyLogo from '~/components/VuetifyLogo.vue'

export default {
  components: {
    Logo,
    VuetifyLogo,
  },
  data: () => ({
    dialogm1: '',
    dialog: false,
    chips: [
      {
        active: true,
        name: 'general'
      },
      {
        active: false,
        name: 'random'
      },
      {
        active: true,
        name: 'agenda'
      },
    ],
    files: [
      {
        color: 'blue',
        icon: 'mdi-clipboard-text',
        subtitle: 'Jan 20, 2014',
        title: 'Vacation itinerary',
      },
      {
        color: 'amber',
        icon: 'mdi-gesture-tap-button',
        subtitle: 'Jan 10, 2014',
        title: 'Kitchen remodel',
      },
    ],
    folders: [
      {
        subtitle: '23件のメッセージ',
        title: 'スライドレビュー',
      },
      {
        subtitle: '19件のメッセージ',
        title: '発表',
      },
      {
        subtitle: '18件のメッセージ',
        title: 'ポスター',
      },
    ],
    dates: ['2020-09-10', '2020-09-20'],
    labels: [
      '8/20',
      '8/24',
      '8/28',
      '9/2',
      '9/6',
      '9/10',
      '9/15',
      '9/20',
    ],
    value: [
      200,
      675,
      410,
      390,
      310,
      460,
      250,
      800,
    ],
  }),
  computed: {
    dateRangeText () {
      return this.dates.join(' ~ ')
    },
    showActiveChannels() {
      return this.chips.filter(chip => chip.active)
    },
  },
}
</script>

<style type="text/css">

/* pタグの改行をなくす */
p {
  display:inline;
}
</style>