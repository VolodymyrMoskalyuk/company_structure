function getIndex(list, id) {
    for (var i = 0; i < list.length; i++) {
        if (list[i].id === id) {
            return i;
        }
    }
    return -1;
}


var companyApi = Vue.resource('/company{/id}');

Vue.component('company-from', {
    props: ['companies', 'companyAttr'],
    data: function () {
        return {
            companyName: '',
            earnings: '',
            childEarnings: '',
            totalAmount: ''
        }
    },
    watch: {
        companyAttr: function (newVal, oldVal) {
            this.companyName = newVal.companyName;
            this.earnings = newVal.earnings;
            this.childEarnings = newVal.childEarnings;
            this.totalAmount = newVal.totalAmount;
            this.id = newVal.id;
        }
    },
    template:
    '<div>' +
    '<input type="text"  placeholder="Enter" v-model="companyName">' +
    '<input type="text"  placeholder="Enter" v-model="earnings">' +
    '<input type="text"  disabled v-model="childEarnings">' +
    '<input type="text" disabled v-model="totalAmount">' +
    '<input type="button"  value="Save" @click="save"/>' +
    '</div>',
    methods: {
        save: function () {
            var company = {
                companyName: this.companyName,
                earnings: this.earnings,
                childEarnings: this.childEarnings,
                totalAmount: this.totalAmount
        }
            ;
            if (this.id) {
                companyApi.update({id: this.id}, company).then(result =>
                    result.json().then(data => {
                        var index = getIndex(this.companies, data.id);
                        this.companies.splice(index, 1, data);
                        this.companyName = ''
                        this.earnings = ''
                        this.childEarnings = ''
                        this.totalAmount = ''
                        this.id = ''
                    })
                )
            } else {
                companyApi.save({}, company).then(result =>
                    result.json().then(data => {
                        this.companies.push(data);
                        this.companyName = ''
                        this.earnings = ''
                        this.childEarnings = ''
                        this.totalAmount = ''
                    })
                )
            }
        }
    }
});

Vue.component('company-row', {
    props: ['company', 'editCompany', "companies"],
    template: '<div>' +
    '{{ company.id }} | {{ company.companyName }} |{{ company.earnings}} | ' +
    '{{company.childEarnings}} | {{company.totalAmount}}' +
    '<span style="position: absolute; right: 0px">' +
    '<input type="button" value="Edit" @click="edit" />' +
    '<input type="button" value="X" @click="del" />' +
    '</span>' +
    '</div>',
    methods: {
        edit: function () {
            this.editCompany(this.company);
        },
        del: function () {
            companyApi.remove({id: this.company.id}).then(result => {
                if (result.ok) {
                    this.companies.splice(this.companies.indexOf(this.company), 1)
                }
            })
        }

    }
});

Vue.component('companies-list', {
    props: ['companies'],
    data: function () {
        return {
            company: null
        }
    },
    template: '<div style="position: relative; width: 500px;">' +
    '<company-from :companies="companies" :companyAttr="company"/>' +
    '<company-row v-for="company in companies" :key="company.id" :company="company" ' +
    ':editCompany="editCompany" :companies="companies"/>' +
    '</div>',
    created: function () {
        companyApi.get().then(result =>
            result.json().then(data =>
                data.forEach(company => this.companies.push(company))
            )
        )
    },
    methods: {
        editCompany: function (company) {
            this.company = company;
        }
    }
});

var app = new Vue({
    el: '#app',
    template: '<companies-list :companies="companies" />',
    data: {
        companies: []
    }
});