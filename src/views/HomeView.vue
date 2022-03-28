<template>
  <div v-if="!userStore.getters.isLoggedIn" class="d-grid gap-2 col-6 mx-auto">
    <FormLogin />
  </div>
  <div v-else class="text-center">
    <h2 id="title">Welcome, {{ userStore.state.name }}</h2>
    <div>
      <a href="https://www.wikipedia.org/">Wikipedia link</a>
    </div>
    <div>
      <img class="my-image" :src="qrImage" alt="test"/>
    </div>
    <div>
      <iframe
        id="iframe"
        title="This is a unique title"
        src="sample.html"
      />
    </div>
    <div>
      <button id="file_download" class="btn btn-secondary" @click="download">
        download
      </button>
    </div>
    <button id="logout" class="btn btn-secondary" @click="logout">
      Logout
    </button>
  </div>
</template>

<script lang="ts">
import {
  defineComponent, onMounted, computed,
} from 'vue';
import userStore from '@/stores/user';
import FormLogin from '@/components/FormLogin.vue';
import FileSaver from 'file-saver';
import { Decoder } from '@nuintun/qrcode';

const qrcode = new Decoder();

export default defineComponent({
  name: 'App',
  components: { FormLogin },
  setup() {
    // eslint-disable-next-line global-require
    const qrImage = computed(() => require('@/assets/test_qr.png'));
    onMounted(() => {
      // eslint-disable-next-line no-unused-expressions
      userStore.getUser;
      qrcode.scan(qrImage.value).then((decode: any) => {
        console.log('this is the decoded qr code', decode.data);
      });
    });
    const logout = () => {
      userStore.logout();
      console.log('logging out');
      console.log(userStore.state);
    };

    const download = () => {
      console.log('downloading');
      const blob = new Blob(['Hello, world!'], { type: 'text/plain;charset=utf-8' });
      FileSaver.saveAs(blob, 'hello world.txt');
    };

    return {
      userStore, logout, download, qrImage,
    };
  },
});
</script>
<style lang="css" scoped>
.my-image {
  width: 200px;
  height: 200px;
}
</style>
