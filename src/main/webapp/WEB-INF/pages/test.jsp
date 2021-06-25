<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="icon" href="resources/admin/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="resources/css/reset.css" />
    <link rel="stylesheet" href="resources/js/element-ui@2.4.11/lib/theme-chalk/index.css"/>
    <link rel="stylesheet" href="resources/bootstrap-4.4.1/css/bootstrap.min.css"  >

    <script src="resources/js/polyfill.min.js"></script>
    <script src="resources/js/vue.min.js"></script>
    <script src="resources/js/element-ui@2.4.11/lib/index.js"></script>
    <script src="resources/js/jquery-3.4.1.min.js" ></script>
    <script src="resources/bootstrap-4.4.1/js/popper.min.js" ></script>
    <script src="resources/bootstrap-4.4.1/js/bootstrap.min.js" ></script>
    <script src="resources/js/modal.js" ></script>

</head>
<body>
<b-button v-b-modal.modal-prevent-closing>Open Modal</b-button>
<b-modal
        id="modal-prevent-closing"
        ref="modal"
        title="Submit Your Name"
        @show="resetModal"
        @hidden="resetModal"
        @ok="handleOk"
>
    <form ref="form" @submit.stop.prevent="handleSubmit">
        <b-form-group
                :state="nameState"
                label="Name"
                label-for="name-input"
                invalid-feedback="Name is required"
        >
            <b-form-input
                    id="name-input"
                    v-model="name"
                    :state="nameState"
                    required
            ></b-form-input>
        </b-form-group>
    </form>
</b-modal>
</body>
</html>
